# Cloud Deployer - DOCKER SWARM

### 시작하기(AWS ECR만 지원)

1. `git`을 설치 후, 해당 레포를 `clone` github 로그인을 필요
2. `cd docker-swarm` 폴더로 이동합니다.
3. `./deploy.sh` 를 실행하여 배포환경 구성을 시작합니다.

---

### 입력 정보

1. Service Name: Docker swarm에서 사용하는 서비스명. 프로그램 이름입니다.
2. Initial Image: 실행하고자 하는 초기 이미지입니다. 빈 linux container일 수도, 어플리케이션 최신 버전일 수도 있습니다.
3. Environment Variable: 컨테이너 내 환경 변수를 설정합니다. \
   `SPRING_PROFILES_ACTIVE=alpha` 등 프로그램에서 사용하는 변수나 JVM Arguments 제공 가능
4. Registry Tag Listener: Registry Tag Listener는 레지스트리의 특정 태그를 구독합니다. \
   이미지 업데이트 발생 시 해당 태그의 최신 버전으로 스스로 변경하는 기능입니다. \
   `alpha` 태그를 바라보고 있다면, 레지스트리에 `0.0.2, alpha` 태그 이미지가 새로운 이미지가 업로드되며 `0.0.2`와 `0.0.3, alpha`로 변경되었다면, `alpha` 태그가 가리키는 `0.0.3`버전 컨테이너로 스스로 업데이트합니다.
5. Replica: 동일한 서비스를 여러 컨테이너를 통해 분산처리시켜 위기 상황에서의 대응 등을 용이하게 하기 위한 기능입니다. \
   Load Balancing, 다중화, Pod Liveness Check/Failure handling 등의 기능을 지원받기 위해서는 Docker swarm보다 Kubernetes를 이용하는 것이 바람직합니다. Docker Swarm에서는 단순히 동시 실행 서비스를 제공하는 용도로만 사용하세요.
6. Image Registry Vendor: 이미지 레지스트리를 제공하는 업체/서비스를 나타냅니다. 현재는 AWS ECR만 지원합니다.

---

### AWS ECR(Elastic Container Registry)

- 이미지 레지스트리 URI: 계정의 이미지 레지스트리를 의미하며, `<AWS_USER_ID>.dkr.ecr.<AWS_REGION>.amazonaws.com` 의 형식을 가지고 있습니다.
- 이미지 이름: AWS에 업로드된 이미지 이름(레지스트리 이름)을 나타냅니다.
- 배포 태그: 자동 업데이트 사용시 바라볼 태그 이름을 나타냅니다.
- Region: ECR이 사용되고 있는 AWS Region을 나타냅니다.(서울 - ap-northeast-2)
