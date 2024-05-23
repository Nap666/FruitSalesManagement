package admin

type SearchController struct {
	BaseController
}

func (c SearchController) Get() {
	c.TplName = "itying/product/search.html"
}
