package main

import (
	"time"

	"github.com/paw-digital/nano/node"
	"github.com/paw-digital/nano/store"
)

func main() {
	store.Init(store.LiveConfig)

	keepAliveSender := node.NewAlarm(node.AlarmFn(node.SendKeepAlives), []interface{}{node.PeerList}, 20*time.Second)
	node.ListenForUdp()

	keepAliveSender.Stop()
}
