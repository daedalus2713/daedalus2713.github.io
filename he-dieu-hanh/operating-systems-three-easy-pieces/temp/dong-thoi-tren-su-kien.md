---
description: Event-based concurrency
---

# Đồng thời trên sự kiện

## 1. Ý tưởng đơn giản - vòng lặp sự kiện

\_ Khởi tạo 1 vòng lặp liên tục kiểm tra các sự kiện và thực hiện các công việc để xử lý sự kiện đó.

\_ Các đoạn mã được dùng để xử lý sự kiện gọi là **event handler**.

* Hành động duy nhất trong hệ thống
* Kiểm soát được hoạt động nào sẽ được diễn ra tiếp theo.

## 2. API quan trọng: select\(\) \(hoặc poll\)

\_ Cung cấp cho chương trình khả năng kiểm tra xem có sự kiện I/O đang tới nào để có thể xử lý.

```text
int select(int nfds,
           fd_set *restrict readfds,
           fd_set *restrict writefds,
           fd_set *restrict errorfds,
           struct timeval *restrict timeout);
```

* Kiểm tra các **descriptor set** để biết được trạng thái của file đang được xử lý
* Trả về số lượng **descriptor set** đã sẵn sàng cho hoạt động yêu cầu
* Time out
  * NULL: chờ đến khi toàn bộ các fds sẵn sàng
  * 0: trả về ngay lập tức

## 3. Blocking system call

\_ Thông thường các lời gọi hệ thống sẽ bị chặn lại cho đến khi được hoàn thành.

\_ Trong các hệ thống dựa trên sự kiện, chỉ có 1 vòng lặp được chạy, các lời gọi hệ thống bị chặn sẽ làm cho hệ thống không thể phản hồi dẫn tới lãng phí các tài nguyên khác.

\_ Cần phải tạo ra các **handler** mà không chặn toàn bộ hệ thống.

## 4. Asynchronous I/O

\_ Cho phép các chương trình thực hiện lời gọi I/O mà được trả về luôn, không cần đợi I/O đó hoàn thành. Cùng với đó, cũng có các hàm được cung cấp để kiểm tra xem I/O đã được hoàn thành xong chưa.

\_ Có thêm 1 cấu trúc để quản lý **AIO control block** \(_aiocb_\):

```text
struct aiocb {
    int            aio_fildes;        /*File descriptor*/
    off_t          aio_offset;        /*File offset*/
    volatile void  *aio_buf;          /*Location of buffer*/
    size_t         aio_nbytes;        /*Length of transfer*/
};
```

\_ Các lời gọi asynchronous I/O sẽ trả về ngay lập tức và để cho hệ thống có thể tiếp tục chạy.

\_ Để kiểm tra xem AIO đó đã hoàn thành chưa, sẽ gọi hàm kiểm tra aiocb đó

* Trả về thành công nếu đã xong
* Trả về EINPROGRESS nếu vẫn đang thực hiện

\_ Một số hệ thống có thể dựa trên **interrupt,** các **UNIX signals** để thông báo cho các chương trình khi nào AIO được hoàn thành.

## 5. Quản lý trạng thái

\_ Lý do: khi chương trình yêu cầu một AIO, cần phải đóng gói các trạng thái của chương trình để có thể sử dụng khi mà AIO được hoàn thành. =&gt; **manual stack management**. 

\_ **continuation**:

* Lưu lại các thông tin cần phải có để hoàn thành sự kiện này
* Khi sự kiện xảy ra, tìm kiếm các thông tin cần thiết và xử lý

## 6. Khó khăn

\_ Ở các hệ thống đa CPU:

* Tối ưu hóa sử dụng CPU
* Các vấn đề đồng bộ bình thường

\_ Paging: 

* Các event-handler page faults, chương trình sẽ bị block, hệ thống sẽ dừng cho tới khi page fault hoàn thành.
* Rất khó để tránh và cần đánh đổi hiệu năng để xử lý

\_ Các API có thể được thay đổi theo thời gian, từ blocking sang non-blocking và ngược lại. Gây khó khăn cho việc bảo trì mã nguồn.

\_ Các asynchronous I/O thường phải kết hợp với nhau để có thể hoàn thành các công việc yêu cầu. 



