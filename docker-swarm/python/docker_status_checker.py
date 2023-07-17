import subprocess
import inspect

def check_local_swarm_initialization() -> bool:
    """
    Docker Swarm 서비스가 정상적으로 실행되어있는지 확인,
    active, inactive 이외의 상태는 예외발생.
    """
    try:
        process_result = subprocess.run(
            ["docker", "info", "--format", "\"{{.Swarm.LocalNodeState}}\""], capture_output=True)
        if (process_result.returncode != 0):
            raise RuntimeError(inspect.cleandoc(f"""
        command fail: {' '.join(process_result.args)}
        command result: {process_result.returncode}: {process_result.stderr}
      """))

        result_stdout = process_result.stdout.decode("utf-8").strip()

        if (result_stdout == '"active"'):
            return True
        elif (result_stdout == '"inactive"'):
            return False
        else:
            raise RuntimeError(inspect.cleandoc(f"""
        Unable to check the status of the docker swarm service.
        Status result: {result_stdout}
      """))
    except subprocess.CalledProcessError:
        return False

def initialize_local_swarm() -> None:
    """
    로컬 도커 스웜 초기화
    """
    subprocess.run(["docker", "swarm", "init"])
    print("Local docker swarm initialize success.")
