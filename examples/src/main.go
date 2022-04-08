package main

import (
	"log"
	"net/http"
	"os"

	"github.com/aws/aws-lambda-go/events"
	"github.com/aws/aws-lambda-go/lambda"
)

var errorLogger = log.New(os.Stderr, "ERROR ", log.Llongfile)

func statusHandler(req events.APIGatewayProxyRequest) (events.APIGatewayProxyResponse, error) {
	return okResponse("ok")
}

func redirectHandler(req events.APIGatewayProxyRequest) (events.APIGatewayProxyResponse, error) {
	if url, ok := req.QueryStringParameters["url"]; ok {
		return redirectResponse(true, url)
	}
	return redirectResponse(true, "https://google.com")
}

func okResponse(response string) (events.APIGatewayProxyResponse, error) {
	return events.APIGatewayProxyResponse{
		StatusCode: http.StatusOK,
		Body:       response,
	}, nil
}

func okResponseWithHeaders(response string, headers map[string]string) (events.APIGatewayProxyResponse, error) {
	return events.APIGatewayProxyResponse{
		StatusCode: http.StatusOK,
		Body:       response,
		Headers:    headers,
	}, nil
}

func redirectResponse(permanent bool, location string) (events.APIGatewayProxyResponse, error) {
	statusCode := http.StatusFound
	if permanent {
		statusCode = http.StatusMovedPermanently
	}
	return events.APIGatewayProxyResponse{
		StatusCode: statusCode,
		Headers: map[string]string{
			"Location": location,
		},
	}, nil
}

func clientError(status int) (events.APIGatewayProxyResponse, error) {
	return events.APIGatewayProxyResponse{
		StatusCode: status,
		Body:       http.StatusText(status),
	}, nil
}

func serverError(err error) (events.APIGatewayProxyResponse, error) {
	errorLogger.Println(err.Error())

	return events.APIGatewayProxyResponse{
		StatusCode: http.StatusInternalServerError,
		Body:       http.StatusText(http.StatusInternalServerError),
	}, nil
}

func handleRequest(req events.APIGatewayProxyRequest) (events.APIGatewayProxyResponse, error) {
	log.Printf("%+v\n", req)
	path := req.Path
	switch path {
	case "/status":
		return statusHandler(req)
	case "/redirect":
		return redirectHandler(req)
	default:
		return clientError(http.StatusMethodNotAllowed)
	}
}

func main() {
	lambda.Start(handleRequest)
}
