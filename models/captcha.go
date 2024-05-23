package models

import (
	"github.com/beego/beego/v2/client/cache"
	"github.com/beego/beego/v2/server/web/captcha"
)

var Cpt *captcha.Captcha

// 图片验证码
func init() {
	store := cache.NewMemoryCache()
	Cpt = captcha.NewWithFilter("/captcha/", store)
	Cpt.ChallengeNums = 4
	Cpt.StdWidth = 100
	Cpt.StdHeight = 40
}
