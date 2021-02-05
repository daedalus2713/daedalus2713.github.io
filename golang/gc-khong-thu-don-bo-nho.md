# GC không thu dọn bộ nhớ

Gần đây mình gặp một trường hợp khá thú vị đó là khi ghi file bằng I/O buffer thì dù làm kiểu gì cũng không thể giảm được bộ nhớ của chương trình. Dù đã kiểm tra từng hàm đọc, ghi file và gọi cả runtime.GC\(\) nhưng bộ nhớ vẫn không thay đổi và tăng nhiều hơn.

 Sau đó mình có tìm được một issue trên github của go nói về vấn đề này: [https://github.com/golang/go/issues/41818](https://github.com/golang/go/issues/41818)

Ở đây giải thích rằng, mỗi khi GC dọn xong và có page trống thì nó sẽ gọi một system call là **madvise\(2\)**, hàm này sẽ thông báo cho HĐH rằng nó có thể lấy page đó mà không cần phải chuyển dữ liệu xuống đĩa.  
Cơ chế này gần giống cơ chế xóa file, HĐH sẽ đánh dấu các ô nhớ là có thể ghi đè được chứ không phải chuyển toàn bộ các ô nhớ đó về 0.

* Nếu HĐH lấy page đó do thiếu bộ nhớ,  nó sẽ giảm giá trị RSS\(\*\) của chương trình.
* Nếu không, nó sẽ bỏ qua lời gọi hệ thống và page sẽ được giữ nguyên. Ở đây sẽ gây ra hiện tượng rằng dù GC đã chạy và page là free, nhưng chương trình vẫn chiếm rất nhiều bộ nhớ.

Để khắc phục vấn đề này, chúng ta có thể gọi **madvise\(MADV\_DONTNEED\)** để chỉnh sửa RSS của chương trình, hay nói cách khác, là HĐH sẽ luôn lấy lại các page free gọi hàm này.

Trong Go, để thực hiện giải pháp nói trên. Chúng ta có thể sử dụng:

* Set the enviroment GODEBUG=madvdontneed=1. 
* Use the function debug.FreeOSMemory\(\).

## Đôi điều về hàm madvise\(\)

Reference: [https://man7.org/linux/man-pages/man2/madvise.2.html](https://man7.org/linux/man-pages/man2/madvise.2.html)

Chức năng: đưa ra chỉ dẫn hoặc gợi ý cho kernel về một vùng nhớ. Thông qua các giá trị gợi ý \(conventional advice values\)

**MADV\_DONTNEED**: có nghĩa rằng chương trình sẽ không cần đến vùng nhớ đó, HĐH có thể dọn luôn ngay khi gọi hàm. Tuy nhiên, việc này có thể làm cho chi phí của những lần page fault cao hơn và tốn thời gian để HĐH cấp lại bộ nhớ cho tiến trình đó.  

## Giải thích

\(1\) **RSS** is the Resident Set Size and is used to show how much memory is allocated to that process and is in RAM. This is not a measure of how much memory is a program using, it is the resident segment size -- the current amount of memory in core for the process.

