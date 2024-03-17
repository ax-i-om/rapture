/*
Copyright © 2024 ax-i-om <addressaxiom@pm.me>

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

	http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

// Package main ...
package main

import (
	"embed"
	"fmt"
	"io"
	"net/http"

	"github.com/TwiN/go-color"
	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"
)

//go:embed static
var sFiles embed.FS

const WEBPORT int = 6175
const SOLRIP string = "solr1" // randomize?
const SOLRPORT string = "8983"

func main() {
	e := echo.New()

	e.HideBanner = true
	e.HidePort = true

	e.Use(middleware.StaticWithConfig(middleware.StaticConfig{
		Root:       "static",
		Browse:     true,
		Filesystem: http.FS(sFiles),
	}))

	e.GET("/query/:query", func(c echo.Context) error {
		x, err := query(c.Param("query"))
		if err != nil {
			return c.JSON(http.StatusInternalServerError, err)
		}
		return c.String(http.StatusOK, x)
	})

	e.GET("/records", func(c echo.Context) error {
		x, err := records()
		if err != nil {
			return c.JSON(http.StatusInternalServerError, err)
		}
		return c.String(http.StatusOK, x)
	})

	fmt.Println(color.Colorize(color.Blue, "[i]"), "HTTP server started on", color.Colorize(color.Green, "[::]:"+fmt.Sprint(WEBPORT)))
	fmt.Println(color.Colorize(color.Blue, "[i]"), "Access Rapture via", color.Colorize(color.Green, "localhost:"+fmt.Sprint(WEBPORT)))

	go e.Logger.Fatal(e.Start(":" + fmt.Sprint(WEBPORT)))
}

func records() (string, error) {
	url := "http://" + SOLRIP + ":" + SOLRPORT + "/solr/BigData/query?debug=query&q=*:*"
	method := "GET"

	client := &http.Client{}
	req, err := http.NewRequest(method, url, nil)

	if err != nil {
		return "", err
	}
	res, err := client.Do(req)
	if err != nil {
		return "", err
	}
	defer res.Body.Close()

	body, err := io.ReadAll(res.Body)
	if err != nil {
		return "", err
	}
	return string(body), nil
}

func query(q string) (string, error) {
	url := "http://" + SOLRIP + ":" + SOLRPORT + "/solr/BigData/select?" + q + "&wt=json"
	method := "GET"

	client := &http.Client{}
	req, err := http.NewRequest(method, url, nil)

	if err != nil {
		return "", err
	}
	res, err := client.Do(req)
	if err != nil {
		return "", err
	}
	defer res.Body.Close()

	body, err := io.ReadAll(res.Body)
	if err != nil {
		return "", err
	}
	return string(body), nil
}
