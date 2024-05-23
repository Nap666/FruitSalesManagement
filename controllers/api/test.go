package api

import (
	beego "github.com/beego/beego/v2/server/web"
)

type TestController struct {
	beego.Controller
}
type Response struct {
	Message string `json:"message"`
	Status  int    `json:"status"`
}
