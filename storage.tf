
resource "kubernetes_storage_class" "ebs_gp3" {
  depends_on = [module.eks]

  provisioner "local-exec" {
    command = "aws eks --region ${var.region} update-kubeconfig --name ${var.cluster_name}"
  }

  provisioner "local-exec" {
    command = "kubectl apply -k 'github.com/kubernetes-csi/external-snapshotter/client/config/crd?ref=master'"
  }

  provisioner "local-exec" {
    command = "kubectl apply -k 'github.com/kubernetes-csi/external-snapshotter/deploy/kubernetes/snapshot-controller?ref=master'"
  }

  provisioner "local-exec" {
    command = "kubectl patch storageclass gp2 -p '{\"metadata\": {\"annotations\":{\"storageclass.kubernetes.io/is-default-class\":\"false\"}}}'"
  }

  metadata {
    name = "ebs-gp3"
    annotations = {
      "storageclass.kubernetes.io/is-default-class" = true
    }
  }

  storage_provisioner    = "ebs.csi.aws.com"
  reclaim_policy         = "Delete"
  volume_binding_mode    = "WaitForFirstConsumer"
  allow_volume_expansion = true

  parameters = {
    type       = "gp3"
    iops       = 3000
    throughput = 500
  }
}

resource "kubernetes_storage_class" "ebs_gp2" {
  depends_on = [module.eks]

  metadata {
    name = "ebs-gp2"
  }

  storage_provisioner    = "ebs.csi.aws.com"
  reclaim_policy         = "Delete"
  volume_binding_mode    = "WaitForFirstConsumer"
  allow_volume_expansion = true

  parameters = {
    type = "gp2"
  }
}

resource "kubernetes_storage_class" "ebs_io2" {
  depends_on = [module.eks]

  metadata {
    name = "ebs-io2"
  }

  storage_provisioner    = "ebs.csi.aws.com"
  reclaim_policy         = "Delete"
  volume_binding_mode    = "WaitForFirstConsumer"
  allow_volume_expansion = true

  parameters = {
    type                       = "io2"
    iopsPerGB                  = 100
    allowAutoIOPSPerGBIncrease = true
  }
}
