# Copy-on-write

\_ Khi khởi tạo object mới, nếu có **cùng thông tin** hệ điều hành sẽ chỉ cung cấp con trỏ của object tới các trang cũ và đánh dấu là copy-on-write.

\_ Chỉ khi nào có page được chỉnh sửa thì HĐH mới copy trang đó và thay đổi thông tin

