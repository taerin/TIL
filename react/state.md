# state

``` javascript
class Counter extends React.Component {
	constructor(props) {
		super(props); // 부모생성자를 초기화 해주어야 this.state 를 접근할 수 있다. 

		this.state = {
			value:0
		};

		this.handleClick = this.handleClick.bind(this)
	}

	handleClick() {
		this.setState({
			value:this.state.value + 1
		});

		// 아래 두줄 코드처럼 state 변경은 직접 접근하면 안된다! this.forceUpdate를 통하여 변경된 값에 대해 강제적으로 update를 해줄 수는 있지만 react의 장점인 바뀐 부분만 update되는 기능을 제대로 사용할 수 없게된다.
		// state 의 변경은 꼭 위와같은 방법으로 할것!
		this.state.value = this.state.value + 1
		this.forceUpdate();
	}

	render() {
		return (
				<div>
				<h2>{this.state.value}</h2>
				<button onClick = {this.handleClick}>Press Me</button>
				// <button onClick = {this.handleClick.bind(this)}>Press Me</button> this를 못찾기 때문에 bind를 해주어야 한다. 하지만 생성자에서 바인드해주는것이 더 좋다.
				// 버튼 이벤트 클릭 부착은 javascript와 같으니 react document에 더 많은 이벤트들이 있다.
				</div>
			   )
	}
}

class App extends React.Component {
	render() {
		return (
				<Counter/>
			   );
	}
};

ReactDOM.render(
		<App></App>,
		document.getElementById("root")
		);
```
