package models

import (
	"context"
	"encoding/json"
	"fmt"
	"time"

	"github.com/beego/beego/v2/client/cache"
	_ "github.com/beego/beego/v2/client/cache/redis"
	beego "github.com/beego/beego/v2/server/web"
	_ "github.com/beego/beego/v2/server/web/captcha"
)

var redisClient cache.Cache

var enableRedis, _ = beego.AppConfig.Bool("enableRedis")
var redisTime, _ = beego.AppConfig.Int("redisTime")

func init() {

	redisKey, _ := beego.AppConfig.String("redisKey")
	redisConn, _ := beego.AppConfig.String("redisConn")
	redisDbNum, _ := beego.AppConfig.String("redisDbNum")
	redisPwd, _ := beego.AppConfig.String("redisPwd")

	if enableRedis {
		config := map[string]string{
			"key":      redisKey,
			"conn":     redisConn,
			"dbNum":    redisDbNum,
			"password": redisPwd,
		}
		//将config转化为json字符格式，并且赋值给bytes,eg{"key":"rediskey","conn": "redisConn"}
		bytes, _ := json.Marshal(config)
		redisClient, err = cache.NewCache("redis", string(bytes))
		if err != nil {
			fmt.Println("连接redis数据库失败")
		} else {
			fmt.Println("连接redis数据库成功")
		}
	}

}

// 定义结构体  缓存结构体 私有
type cacheDb struct{}

//注意：新版redis模块在执行Put和Get的时候需要传入context.TODO()

// 写入数据的方法
func (c cacheDb) Set(key string, value interface{}) {
	if enableRedis {
		//据结构转换为 JSON 格式的数据
		bytes, _ := json.Marshal(value)
		redisClient.Put(context.TODO(), key, string(bytes), time.Second*time.Duration(redisTime))

	}
}

// 获取数据的方法
func (c cacheDb) Get(key string, obj interface{}) bool {
	if enableRedis {
		if redisStr, _ := redisClient.Get(context.TODO(), key); redisStr != nil {
			redisValue, ok := redisStr.([]uint8) //类型断言 []uint8
			if !ok {
				fmt.Println("获取redis户数失败")
				return false
			}
			json.Unmarshal([]byte(redisValue), obj)
			return true
		}
		return false
	}
	return false
}

// 实例化结构体，创建单例对象
var CacheDb = &cacheDb{}
