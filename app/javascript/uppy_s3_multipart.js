import Uppy from '@uppy/core'
import Dashboard from '@uppy/dashboard'
import AwsS3Multipart from '@uppy/aws-s3-multipart'

// 動画アップロード用のUppyインスタンスを初期化
export function initializeUppy(modelType, modelId) {
  const uppy = new Uppy({
    debug: true,
    autoProceed: false,
    restrictions: {
      maxFileSize: 5 * 1024 * 1024 * 1024, // 5GB
      maxNumberOfFiles: 1,
      allowedFileTypes: ['video/*']
    }
  })
  .use(Dashboard, {
    inline: true,
    target: '#uppy-dashboard',
    proudlyDisplayPoweredByUppy: false,
    height: 300
  })
  .use(AwsS3Multipart, {
    limit: 4, // 同時にアップロードするパートの数
    companionUrl: '/s3/multipart', // Railsのエンドポイント
    retryDelays: [0, 1000, 3000, 5000],
    createMultipartUpload(file) {
      // アップロード開始時のパラメータを設定
      const metadata = {}
      return {
        metadata,
        model_type: modelType,
        model_id: modelId
      }
    }
  })

  // アップロード進捗の表示
  uppy.on('upload-progress', (file, progress) => {
    const percent = (progress.bytesUploaded / progress.bytesTotal * 100).toFixed(2)
    console.log(`${file.name}: ${percent}%`)
  })

  // アップロード完了時の処理
  uppy.on('upload-success', (file, response) => {
    console.log('Upload completed:', file.name)
    // 必要に応じて、アップロード完了後の処理を追加
  })

  // エラー発生時の処理
  uppy.on('upload-error', (file, error, response) => {
    console.error('Upload error:', error)
    alert('アップロードエラーが発生しました。もう一度お試しください。')
  })

  return uppy
}