package main

import (
	"net/http"

	"github.com/amitbikram/financial-app-backend/internal/api"
	"github.com/sirupsen/logrus"
)

// create server object and start listener
func main() {
	logrus.SetLevel(logrus.DebugLevel)

	router, err := api.NewRouter()

	if err != nil {
		logrus.WithError(err).Fatal("Error creating router")
	}
	const addr = "0.0.0.0:8088"

	server := http.Server{
		Addr:    addr,
		Handler: router,
	}

	if err := server.ListenAndServe(); err != nil && err != http.ErrServerClosed {
		logrus.WithError(err).Error("Server failed")
	}
}
