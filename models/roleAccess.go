package models

import (
	_ "github.com/jinzhu/gorm"
)

type RoleAccess struct {
	RoleId   int
	AccessId int
}

func (RoleAccess) TableName() string {
	return "role_access"
}
