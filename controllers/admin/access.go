package admin

import (
	"beegoxiaomi/models"
	"strconv"
)

type AccessController struct {
	BaseController
}

func (c *AccessController) Get() {
	access := []models.Access{}
	models.DB.Preload("AccessItem").Where("module_id=0").Find(&access)
	c.Data["accessList"] = access
	c.TplName = "admin/access/index.html"
}

func (c *AccessController) Add() {
	//加载顶级模块
	access := []models.Access{}
	models.DB.Where("module_id=0").Find(&access)
	c.Data["accessList"] = access
	c.TplName = "admin/access/add.html"
}

func (c *AccessController) DoAdd() {

	moduleName := c.GetString("module_name")
	iType, err1 := c.GetInt("type")
	actionName := c.GetString("action_name")
	url := c.GetString("url")
	moduleId, err2 := c.GetInt("module_id")
	sort, err3 := c.GetInt("sort")
	description := c.GetString("description")
	status, err4 := c.GetInt("status")
	if err1 != nil || err2 != nil || err3 != nil || err4 != nil {
		c.Error("传入参数错误", "/access/add")
		return
	}
	access := models.Access{
		ModuleName:  moduleName,
		Type:        iType,
		ActionName:  actionName,
		Url:         url,
		ModuleId:    moduleId,
		Sort:        sort,
		Description: description,
		Status:      status,
	}
	err := models.DB.Create(&access).Error
	if err != nil {
		c.Error("增加数据失败", "/access/add")
	} else {
		c.Success("增加数据成功", "/access")
	}

}

func (c *AccessController) Edit() {
	//获取要修改的数据
	id, err1 := c.GetInt("id")
	if err1 != nil {
		c.Error("传入参数错误", "/access")
		return
	}
	access := models.Access{Id: id}
	models.DB.Find(&access)
	c.Data["access"] = access

	//获取顶级模块
	accessList := []models.Access{}
	models.DB.Where("module_id=0").Find(&accessList)
	c.Data["accessList"] = accessList

	c.TplName = "admin/access/edit.html"
}

func (c *AccessController) DoEdit() {
	id, err1 := c.GetInt("id")
	moduleName := c.GetString("module_name")
	iType, err2 := c.GetInt("type")
	actionName := c.GetString("action_name")
	url := c.GetString("url")
	moduleId, err3 := c.GetInt("module_id")
	sort, err4 := c.GetInt("sort")
	description := c.GetString("description")
	status, err5 := c.GetInt("status")
	if err1 != nil || err2 != nil || err3 != nil || err4 != nil || err5 != nil {
		c.Error("传入参数错误", "/access")
		return
	}
	access := models.Access{Id: id}
	models.DB.Find(&access)
	access.ModuleName = moduleName
	access.Type = iType
	access.ActionName = actionName
	access.Url = url
	access.ModuleId = moduleId
	access.Sort = sort
	access.Description = description
	access.Status = status
	err := models.DB.Save(&access).Error
	if err != nil {
		c.Error("修改失败", "/access/edit?id="+strconv.Itoa(id))
		return
	}
	c.Success("修改成功", "/access/")

}

func (c *AccessController) Delete() {

	id, err1 := c.GetInt("id")
	if err1 != nil {
		c.Error("传入参数错误", "/access")
		return
	}
	//获取当前数据
	access1 := models.Access{Id: id}
	models.DB.Find(&access1)
	if access1.ModuleId == 0 { //顶级模块
		access3 := []models.Access{}
		models.DB.Where("module_id=?", access1.Id).Find(&access3)
		if len(access3) > 0 {
			c.Error("当前模块下面还有菜单或者操作，无法删除", "/access")
			return
		}
	}
	access2 := models.Access{Id: id}
	models.DB.Delete(&access2)
	c.Success("删除成功", "/access")

}
