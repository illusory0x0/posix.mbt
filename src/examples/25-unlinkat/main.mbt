///|
fn main {
  let (dir, rc_dir) = @native.CStr::from_bytes(b"tmp\x00")
  let dirfd = @posix.openat(
    @posix.at_fdcwd, dir, @posix.o_directory, @posix.directory_default_mode,
  )
  let (file, rc_file) = @native.CStr::from_bytes(b"input.txt\x00")
  let status = @posix.unlinkat(dirfd, file, 0)
  if status.is_error() {
    println("unlinkat failed")
  } else {
    println("unlinkat success")
  }
  rc_file.release()
  rc_dir.release()
  @posix.close(dirfd) |> ignore
}
