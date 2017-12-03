{
  num = split($0, arr, ":")
  for (i = 1; i <= num; i++) {
    for (j = 1; j < i; j++) {
      if (arr[i] == arr[j]) {
        arr[i] = ""
        break
      }
    }
  }
  for (i = 1; i <= num; i++) {
    if (length(arr[i]) > 0) {
      str1 = str1 ":" arr[i]
    }
  }
  print substr(str1, 2, length(str1))
}
