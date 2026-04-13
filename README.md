# Установка и настройка Talos + Vagrant + libvirt

## Установка необходимых пакетов

```bash
apt install virt-manager nc vagrant vagrant-libvirt libvirt-dev
systemctl enable --now libvirtd
modprobe tun
```

## Настройка сети

Создайте мостовой интерфейс `br0`.

## Установка плагина Vagrant

```bash
vagrant plugin install vagrant-libvirt
```

## Запуск виртуальных машин

```bash
vagrant up --provider=libvirt
```

После запуска:
- Удалите NAT-сеть Vagrant через `virt-manager` или `virsh`, чтобы избежать конфликтов.

## Установка Talos CLI

```bash
curl -sL https://talos.dev/install | sh
```

## Генерация конфигурации кластера

```bash
talosctl gen config cluster.local https://10.0.0.173:6443 \
  --install-disk /dev/vda \
  -f \
  --config-patch @config_path.yaml
```

## Редактирование конфигурации

Отредактируйте файлы `controlplane.yaml` и `worker.yaml`:

```yaml
network:
  interfaces:
    - deviceSelector:
        busPath: "0*"
      dhcp: true
```

## Настройка переменных окружения

```bash
export TALOSCONFIG=$(realpath ./talosconfig)
```

## Указание endpoint'ов

```bash
talosctl config endpoint 10.0.0.154 10.0.0.177 10.0.0.203 10.0.0.249
```

## Применение конфигурации к нодам

### Control Plane

```bash
talosctl -n 10.0.0.173 apply-config --insecure --file controlplane.yaml
talosctl -n 10.0.0.131 apply-config --insecure --file controlplane.yaml
talosctl -n 10.0.0.234 apply-config --insecure --file controlplane.yaml
```

### Worker Nodes

```bash
talosctl -n 10.0.0.162 apply-config --insecure --file worker.yaml
talosctl -n 10.0.0.100 apply-config --insecure --file worker.yaml
```

## Bootstrap кластера

```bash
talosctl -n 10.0.0.173 bootstrap
```

## Получение kubeconfig

```bash
talosctl -n 10.0.0.131 kubeconfig ./kubeconfig -f
```

## Настройка kubectl

```bash
mkdir -p ~/.kube
cp ~/.kube/config ~/.kube/config-old-$(date +%Y-%m-%d_%H-%M_%S)
cp ./kubeconfig ~/.kube/config
```

## Проверка нод

```bash
kubectl get nodes -o wide
```

## Обновление Talos

```bash
talosctl upgrade \
  -n 10.0.0.113 \
  -e 10.0.0.154 \
  --image ghcr.io/siderolabs/installer:latest \
  --talosconfig=talosconfig
```

Ожидаемый вывод:

```
watching nodes: [10.0.0.113]
    * 10.0.0.113: post check passed
```

## Обновление Kubernetes

```bash
talosctl upgrade-k8s \
  --to 1.33.3 \
  -n 10.0.0.154 \
  -e 10.0.0.154 \
  --talosconfig=talosconfig
```

## Полезная ссылка

- https://docs.siderolabs.com/talos/v1.11/getting-started/support-matrix
