# Lưu ý khi function trả về

```go
type ExampleStruct struct {
    Value int
}

func (e *ExampleStruct) Print() {
    fmt.Println(e.Value)
}    


func Example(param1 int, param2 int) (result *ExampleStruct, err error) {    
    // check error
    if param1 < 0 {
        return nil, errors.New("Negative")
    }
    
    // do sth with the param
    tmp := param1 + param2

    result.Print()     // panic: nil pointer
    result.Value = tmp // painc: nil pointer
    
    // allocate the result (method 1)
    result = new(ExampleStruct)
    result.Value = tmp
    
    // allocate the result (method 2)
    result = &ExampleStruct{
        Value: tmp,
    }
    
    return result, nil
}

```

Khi khai báo con trỏ trong biến trả về, Go chưa tạo ra object đó.   
Cho nên khi gán giá trị cho object đó hoặc gọi các hàm trong object, Go sẽ tạo ra thông báo nil pointer.

Vậy cần phải khởi tạo biến trả về để tránh việc bộ nhớ không được cấp phát cho biến đó trong chương trình.

Lưu ý, cần khai báo biến hợp lý để tránh việc cấp phát bộ nhớ không cần thiết.

* Khai báo trước khi kiểm tra error \(thường sẽ trả về nil, err nếu có lỗi\) 

