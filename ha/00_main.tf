terraform {
    required_providers {
      azurerm = {
          source = "hashicorp/azurerm"
          version = "=2.90.0"
      }
    }
}

provider "azurerm" {
    features {}

    subscription_id = "268a434d-f7e6-4966-bb27-d29e20a1b360"    # 4-HAJINWOO 구독 ID 설정
}