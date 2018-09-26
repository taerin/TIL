# Node와 Docker
나는 Docker 컨테이너 내의 용량이 증가되기 때문에 node_modules 를 포함하지 않는다고 생각했었다. 하지만 그게 아니라 node는 플랫폼마다 독립적이므로 packge.json을 통해 각 플랫폼에 맞는 모듈 버전을 다운로드 받도록 해야한다. 
용량은 어차피 package.json을 통해서 다운을 받게되므로 컨테이너의 크기는 그게 그거다! 
