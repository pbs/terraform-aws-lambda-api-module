package test

import (
	"fmt"
	"os"
	"testing"
	"time"

	httpHelper "github.com/gruntwork-io/terratest/modules/http-helper"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func testLambdaAPI(t *testing.T, variant string) {
	t.Parallel()

	primaryHostedZone := os.Getenv("TF_VAR_primary_hosted_zone")

	if primaryHostedZone == "" {
		t.Fatal("TF_VAR_primary_hosted_zone must be set to run tests. e.g. 'export TF_VAR_primary_hosted_zone=example.org'")
	}

	terraformDir := fmt.Sprintf("../examples/%s", variant)

	terraformOptions := &terraform.Options{
		TerraformDir: terraformDir,
		LockTimeout:  "5m",
	}

	defer terraform.Destroy(t, terraformOptions)

	expectedName := fmt.Sprintf("ex-tf-lambda-api-%s", variant)

	// This is annoying, but necessary. Log Group isn't cleaned up correctly after destroy.
	logGroupName := fmt.Sprintf("/aws/lambda/%s", expectedName)
	deleteLogGroup(t, logGroupName)

	terraform.InitAndApply(t, terraformOptions)

	region := getAWSRegion(t)

	expectedARNWithoutID := fmt.Sprintf("arn:aws:apigateway:%s::/apis/", region)
	expectedDomainName := fmt.Sprintf("%s.%s", expectedName, primaryHostedZone)

	if variant == "alt-domain" {
		expectedAltDomainName := os.Getenv("TF_VAR_alternate_domain_name")

		if expectedAltDomainName == "" {
			t.Fatalf("TF_VAR_alternate_domain_name must be set to test %s variant. e.g. 'export TF_VAR_alternate_domain_name=example.org'", variant)
		}

		altDomainName := terraform.Output(t, terraformOptions, "alternate_domain_name")
		assert.Equal(t, expectedAltDomainName, altDomainName)
		altDomainEndpoint := terraform.Output(t, terraformOptions, "alternate_domain_endpoint")
		assert.NotEmpty(t, altDomainEndpoint)
	}

	arn := terraform.Output(t, terraformOptions, "arn")
	assert.Contains(t, arn, expectedARNWithoutID)

	domainName := terraform.Output(t, terraformOptions, "domain_name")
	assert.Equal(t, expectedDomainName, domainName)

	statusURL := fmt.Sprintf("https://%s/status", domainName)
	expectedStatus := "ok"

	httpHelper.HttpGetWithRetry(t, statusURL, nil, 200, expectedStatus, 60, 5*time.Second)
}
