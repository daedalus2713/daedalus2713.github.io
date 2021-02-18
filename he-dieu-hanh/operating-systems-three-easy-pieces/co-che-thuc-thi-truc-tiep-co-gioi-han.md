# Cơ chế: Thực thi trực tiếp có giới hạn

Để có thể áo hóa CPU, HĐH cần phải chia sẻ CPU vật lý giữa nhiều công việc chạy song song. Ý tưởng cơ bản là để mỗi tiến trình chạy một thời gian nhỏ rồi chuyển cho tiến trình khác. Đây gọi là chia sẻ theo thời gian.

## 1. Kỹ thuật cơ bản: Thực thi trực tiếp có giới hạn

Thực thi trực tiếp: Chạy chương trình trực tiếp trên CPU.

Khi HĐH muốn khởi chạy 1 tiến trình:

* Tạo ra bản ghi trong danh sách tiến trình
* Cấp phát bộ nhớ
* Lưu code vào trong máy
* Tìm điểm bắt đầu và khởi chạy

Nếu để cho chương trình chạy trực tiếp trên CPU, ta cần phải tìm cách để:

* Đảm bảo chhương trình chạy đúng với mong muốn
* Làm sao để dừng tiến trình và chuyển sang tiến trình khác
* Làm sao để cài đặt cơ chế chia sẻ thời gian nếu muốn ảo hóa CPU

=&gt; Cần phải giới hạn tiến trình 

## 2. Giới hạn hành động

Thực thi trực tiếp cho thấy lợi thế về thời gian, không có chi phí nào khác thêm vào. Tuy nhiên nếu chương trình thực hiện các hành động bị giới hạn như: truy nhập tới thiết bị vào/ra, lấy thêm các tài nguyên khác,...

Cách tiếp cận đầu tiên là cấp quyền cho tiến trình làm gì mà nó muốn, như vậy sẽ không tốn công cài đặt các hệ thống thêm vào. Tuy nhiên, như vậy cũng sẽ đánh mất sự bảo vệ tài nguyên mà một HĐH cần có.

Cách tiếp cận khác là đưa ra chế độ mới cho bộ xử lý, hay còn gọi là chế độ người dùng \(**user mode**\); code chạy ở chế độ này sẽ bị giới hạn các hành động có thể thực thi. Khi tiến trình thực thi hành động bị giới hạn, bộ xử lý sẽ báo lỗi và HĐH sẽ xóa bỏ tiến trình đó.

Đối lập với cả user mode là kernel mode \(chế độ nhân\), đây là chế độ mà HĐH hoặc kernel dùng để chạy. Trong chế độ này, code có thể làm tất cả mọi hành động như yêu cầu, kể cả các hành động bị giới hạn.

Để tiến trình người dùng có thể thực hiện các hành động yêu cầu quyền, hầu như các phần cứng\(được ảo hóa\) đều cung cấp khả năng cho chương trình thực hiện các lời gọi hệ thống.Để thực hiện lời gọn hệ thống, chương trình cần thực thi một chỉ dẫn bẫy đặc biệt \(**special trap instruction**\). 

* Chỉ dẫn này sẽ vào nhân và đưa mức quyền lên _kernel mode_ để thực hiện các hành động yêu cầu quyền.
* Khi các hành động này chạy xong, HĐH gọi tới chỉ dẫn _return-from-trap_ \(thoát bẫy\), trở về chương trình của người dùng với mức quyền là _user mode_.
* Khi thực hiện chỉ dẫn bẫy, HĐH cần đảm bảo có đủ các thanh ghi để trả về chính xác khi thực hiện chỉ dẫn return-from-trap.

Để có thể giới hạn code được thực thi trong 1 trap, kernel tạo ra 1 **trap table** khi khởi động để cấu hình phần cứng của máy khi cần. Điều đầu tiên chính là HĐH có thể thông báo với phần cứng sẽ chạy đoạn code nào khi có 1 sự kiện đặc biệt xảy ra. HĐH sẽ chỉ cho phần cứng vị trí của các bộ xử lý trap \(thường là một số chỉ dẫn đặc biệt\). Khi HĐH được thông báo, nó ghi nhớ vị trí của các bộ xử lý để phục vụ cho lời khởi động tiếp theo.

Khi tiến trình người dùng cần thực hiện lời gọi hàm thì cần phải sử dụng tới **số hiệu lời gọi hàm.** Khi HĐH thực hiện lời gọi hàm đó, số hiệu sẽ được kiểm tra và thực thi code cần thiết. Đây được coi như một sự **bảo vệ** để cho người dùng không được chỉ tới một địa chỉ cụ thể mà chỉ được sử dụng thông qua các số hiệu.

Có 2 giai đoạn trong giao thức thực thi trực tiếp có giới hạn:

* Trong thời gian khởi động, kernal sẽ khởi tạo trap table, CPU sẽ ghi nhớ để cho các lần sử dụng tiếp theo.
* Khi đang chạy 1 tiến trình, kernel sẽ thiết lập các thông tin cần thiết trước khi thực hiện return-from-trap để khởi chạy việc thực thi tiến trình. Sau đó chuyển CPU sang user mode và bắt đầu thực thi tiến trình.
  * Khi tiến trình muốn thực hiện lời gọi hệ thống, các chỉ dẫn sẽ được trap vào HĐH để xử lý và trả lại quyền điều khiển cho tiến trình thông qua return-from-trap.
  * Khi tiến trình chạy xong, nó thường thực hiện code để thoát chương trình, thường là 1 lời gọi hệ thống. Tại thời điểm đó, HĐH dọn dẹp tiến trình. 

## 3. Chuyển đổi giữa các tiến trình

Khi tiến trình đang chạy trực tiếp trên CPU, HĐH lúc đó đang không được chạy. Làm sao để HĐH lấy lại quyền điều khiển của CPU để có thể chuyển đổi giữa các tiến trình ? 

### 3.1. Đợi các lời gọi hệ thống

HĐH cho rằng các tiến trình sẽ thực thi hợp lý, các tiến trình thực thi trong thời gian dài sẽ định kỳ giao CPU cho HĐH để quyết định thực thi các nhiệm vụ khác. Thực tế, đa số các tiến trình sẽ giao lại CPU cho HĐH khi thực hiện các lời gọi hệ thống. Các hệ thống như này thường bao gồm 1 lời gọi hệ thống **yield**, có tác dụng chuyển quyền điều khiển CPU cho HĐH.

Các chương trình cũng chuyển quyền điều khiển cho HĐH khi thực thi các tác vụ bất hợp pháp\(illegal\).

Tuy nhiên, việc gì sẽ xảy ra nếu HĐH không lấy lại được quyền điều khiển ? Các tiến trình sẽ không bao giờ thực hiện các lời gọi hệ thống ?

### 3.2. Hệ điều hành nắm quyền điều khiển

Để có thể lấy lại quyền điều khiển, các hệ thống sử dụng một bộ hẹn giờ ngắt \(**timer interrrupt**\), đây là một thiết bị được lập trình để tạo ra tín hiệu ngắt mỗi chu kỳ\(vài mili giây\). Khi tín hiệu ngắt được tạo ra, tiến trình đang chạy sẽ được tạm dùng, và một bộ xử lý ngắt được cài đặt sẵn trong HĐH sẽ thực thi, từ đó HĐH lấy lại quyền điều khiển của CPU.

Trong thời gian khởi động, HĐH cần phải:

* Thông báo cho phần cứng thực thi đoạn mã nào khi có tín hiệu ngắt
* Khởi động bộ hẹn giờ

Khi tín hiệu ngắt xảy ra, các phần cứng cũng cần phải chịu trách nhiệm ghi nhớ lại trạng thái của chương trình đang chạy để khi return-from-trap có thể tiếp tục chạy đúng.

### 3.3. Lưu và phục hồi ngữ cảnh \(context\)

Khi HĐH lấy lại quyền điều khiển, nó cần quyết định xem nên tiếp tục chạy tiến trình hay là chạy một tiến trình khác. Nếu quyết định chuyển tiến trình, HĐH sẽ thực hiện **context switch:** 

* Lưu vài giá trị thanh ghi của tiến trình đang được thực thi
* Khôi phục các giá trị từ tiến trình chuẩn bị được thực thi

 Sau khi thực hiện, HĐH đảm bảo rằng return-from-trap đã được thực thi, thay vì trở lại tiến trình đang chạy, HĐH tiếp tục thực thi một tiến trình khác.

Để lưu được context của tiến trình đang chạy, HĐH thực thi một số đoạn code assembly bậc thấp để lưu lại các giá trị thanh gi, bộ đếm tiến trình, kernal stack của tiến trình đang được thực thi.

Trong quá trình này, có 2 lạo thanh ghi được lưu/phục hồi:

* Khi tín hiệu ngắt xảy ra, các thanh ghi người dụng của tiến trình đang chạy được lưu bởi phần cứng, sử dụng kernel stack của tiến trình đó
* Khi HĐH muốn chuyển tiến trình,  thanh ghi kernal được lưu lại bởi phần mềm \(vd: HĐH\), vào cấu trúc tiến trình \(**process structure**\) của tiến trình đó. Khi đó, hệ thống sẽ được chuyển từ được bẫy \(trapped\) bởi tiến trình A, sang được bẫy bởi tiến trình B.

## 4. Concurrency

HĐH cần phải quan tâm đến các sự kiện xảy ra khi đang xử lý tiến trình ngắt hoặc bẫy \(trap handling\).

Về cơ bản, HĐH sẽ vô hiệu hóa tín hiệu ngắt khác khi đang xử lý tín hiệu ngắt để đảm bảo không một tín hiệu ngắt nào được chuyển tới CPU. Tuy nhiên khi vô hiệu hóa quá lâu sẽ dẫn tới mất các tín hiệu ngắt.

HĐH đã được phát triển nhiều cơ chế khóa tinh vi để bảo vệ truy cập đồng thời tới 1 cấu trúc dữ liệu bên trong. 



