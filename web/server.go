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
	"net/http"

	"github.com/TwiN/go-color"
	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"
)

//go:embed static
var sFiles embed.FS

const IP string = "127.0.0.1"
const PORT int = 6175

func main() {
	e := echo.New()

	e.HideBanner = true
	e.HidePort = true

	e.Use(middleware.StaticWithConfig(middleware.StaticConfig{
		Root:       "static",
		Browse:     true,
		Filesystem: http.FS(sFiles),
	}))

	fmt.Println(color.Colorize(color.Blue, "[i]"), "HTTP server started on", color.Colorize(color.Green, "[::]:"+fmt.Sprint(PORT)))
	fmt.Println(color.Colorize(color.Blue, "[i]"), "Access Rapture via", color.Colorize(color.Green, IP+":"+fmt.Sprint(PORT)))

	e.Logger.Fatal(e.Start(":" + fmt.Sprint(PORT)))
}
