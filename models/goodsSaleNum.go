package models

type GoodsSaleNum struct {
	Id       int
	GoodsId  int `gorm:"ForeignKey:Id"`
	SaledNum int
}

func (GoodsSaleNum) TableName() string {
	return "goods_sale_num"
}
