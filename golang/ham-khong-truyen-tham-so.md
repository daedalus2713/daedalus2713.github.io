# Hàm không truyền tham số

## Tổng quan

Trong một số trường hợp, khi hàm\(1\) là tham số truyền vào của hàm\(2\) khác thì không cần truyền thêm biến cho hàm\(1\).  
Đây là một cách dùng khá phổ biến trong lập trình Golang nhưng có thể gây ra sự khó hiểu cho người mới bắt đầu.

## Ví dụ thực tế

[https://github.com/gin-gonic/gin\#using-get-post-put-patch-delete-and-options](https://github.com/gin-gonic/gin\#using-get-post-put-patch-delete-and-options)

## Code giải thích

Khi sử dụng phương pháp này, tham số truyền vào của hàm\(1\) sẽ được tạo/tìm trong hàm 2

```go
func PrintString(fn func(str string)) {
    // create the string
    var expStr = "HELLO WORLD"
    fn(expStr)
}

func printStr(str string) {
    fmt.Println(str)
}

// use PrintString
func Use() {
    PrintString(printStr) // Output: HELLO WORLD
}
```

