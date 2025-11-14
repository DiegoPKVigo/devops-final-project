# PostgreSQL

## Install

Ensure you have a default StorageClass that can create persistent volumes in host paths and then install postgresql manifests with `kubectl apply -f manifests/postgresql` command.

## Testing

When everything is running fine (otherwise, troubleshoot with `kubectl describe` and `kubectl logs` until the postgres pod is up and running) run the following instructions:

1. Run `kubectl run -i --tty --rm debug --image=postgres --env="PGHOST=postgres" --env="PGPORT=5432" --env="PGUSER=postgres" --env="PGPASSWORD=your-secret-password" -- bash` to create a postgres client with desired password.
2. Run `psql -h postgres -U postgres` from container shell to ensure the connection is established and can open a admin session.
