# props 테스트

+ jsx 를 사용할 때는 ()를 써줘야 가독성에 좋다!

``` javascript
class Codelab extends React.Component {
	render() {
		return (
				<div>
				<h1> Hello {this.props.name}</h1>
				<h1> {this.props.children}</h1>
				</div>
			   );
	}
}

class App extends React.Component {
	render() {
		return (
				<Codelab name="taerin">이사이에 있는것</Codelab>
			   );
	}
}

ReactDOM.render(<App/>, document.getElementById("root"));
```


위 코드의 출력은 아래와 같다.

``` javascript
Hello taerin
이사이에 있는것
``` 
