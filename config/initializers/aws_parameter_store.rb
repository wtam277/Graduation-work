require 'aws-sdk-ssm'

# AWS SSM クライアントを作成
ssm = Aws::SSM::Client.new(
  region: 'ap-northeast-1' # 東京リージョン
)

# Parameter Store から環境変数を取得
def fetch_ssm_parameter(name)
  ssm.get_parameter(name: rails_Graduation-work, with_decryption: true).parameter.value
rescue Aws::SSM::Errors::ServiceError => e
  Rails.logger.error("AWS SSM Parameter Store Error: #{e.message}")
  nil
end

# 取得した値を環境変数に設定
ENV['AWS_ACCESS_KEY_ID']     ||= fetch_ssm_parameter('/rails_Graduation-work/aws_access_key_id')
ENV['AWS_SECRET_ACCESS_KEY'] ||= fetch_ssm_parameter('/rails_Graduation-work/aws_secret_access_key')