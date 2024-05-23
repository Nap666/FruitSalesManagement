package models

import (
	"github.com/beego/beego/v2/core/logs"
	beego "github.com/beego/beego/v2/server/web"
	"github.com/jinzhu/gorm"
	_ "github.com/jinzhu/gorm/dialects/mysql"
)

var DB *gorm.DB
var err error

func init() {
	mysqladmin, _ := beego.AppConfig.String("mysqladmin")
	mysqlpwd, _ := beego.AppConfig.String("mysqlpwd")
	mysqldb, _ := beego.AppConfig.String("mysqldb")
	mysqlhost, _ := beego.AppConfig.String("mysqlhost")

	DB, err = gorm.Open("mysql", mysqladmin+":"+mysqlpwd+"@("+mysqlhost+")/"+mysqldb+"?charset=utf8&parseTime=True&loc=Local")
	if err != nil {
		logs.Error(err)
	}

	// 自动迁移模式，创建表
	DB.AutoMigrate(&Goods{}, &GoodsSaleNum{})

	// 建立关联关系
	DB.Model(&GoodsSaleNum{}).Association("Goods")
	//DB.Model(&RoleAccess{}).AddForeignKey("role_id", "Role(Id)", "CASCADE", "CASCADE")
	//DB.Model(&RoleAccess{}).AddForeignKey("access_id", "Access(Id)", "CASCADE", "CASCADE")

}
