package awesomeProject2

type Message struct {
	Author string `json:"author"`
	Body   string `json:"body"`
}

func (self *Message) String() string {
	return self.Author + " says " + self.Body
}
