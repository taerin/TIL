# Amazon s3: browser upload vs presigned url

아마존 S3는 Amazon Simple Storage Service 의 약자이다. 
S3내 버켓에 파일을 업로드하는 방식은 크게 두가지 방법이 있다.

바로 
a) REST API를 사용하여 업로드 하는 방법과
b) AWS SDK를 사용하는 방법이다.

a) 만약 REST API 를 사용하고 싶다면 권한에 대한 인증을 받아야 하는데 인증 방법은 크게 세가지다.
  * Using the Authorization Header (AWS Signature Version 4)
  * Using Query Parameters (AWS Signature Version 4)
  * Browser-Based Uploads Using POST (AWS Signature Version 4) 

b) Presigned url을 사용하여 파일을 업로드 하고싶다면 인증하는 절차를 SDK를 통해서 하면된다.
물론 적절한 권한을 설정해두어야만 url을 발급 받을 수 있다.

이 두가지 방법에는 큰 차이점이 있다면 바로 메모리 소모이다.
PutObject를 많이 호출해야하는 곳에서는 GetPreSignedURL로 전환하여 메모리를 절약하는 것이 도움이 될 수 있다.

``` javascript
// 버켓 이름은 _ 를 포함할 수 없고, 대문자로 포함하거나 시작 할 수 없다.
const params = {
    Bucket: "test",
    Key: "photo.png",
    Expires: 60,
};

/**
 * desc: SignedUrl 을 통해 객체 업로드
 */
s3.getSignedUrl("putObject", params, (err, url) => {
    if (err) {
        console.log(err);
    } else {
        console.log(`SignedURL: ${url}`);
    }
});
```

[참고](https://stackoverflow.com/questions/49625833/amazon-s3-direct-upload-vs-presigned-url?rq=1)
