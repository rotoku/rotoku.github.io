# lightning-lab-2_2

```CronJob.yaml
apiVersion: batch/v1
kind: CronJob
metadata:
  name: dice
spec:
  schedule: "*/1 * * * *"
  jobTemplate:
    spec:
      completions: 1
      backoffLimit: 25
      activeDeadlineSeconds: 20
      template:
        spec:
          containers:
          - name: dice
            image: kodekloud/throw-dice
            imagePullPolicy: IfNotPresent
          restartPolicy: Never
```
