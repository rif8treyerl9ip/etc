function copyFolders(sourceFolderId, targetFolderId) {
    var sourceFolder = DriveApp.getFolderById(sourceFolderId);
    var targetFolder = DriveApp.getFolderById(targetFolderId);
  
    // var currentTime = new Date();
    // var currentTimeString = Utilities.formatDate(currentTime, "Asia/Tokyo", "_yyyyMMdd_HHmmss");

    // コピー元フォルダをコピーする
    // var newFolder = targetFolder.createFolder(sourceFolder.getName()+currentTimeString);
    var newFolder = targetFolder.createFolder(sourceFolder.getName());
  
    // コピー元フォルダ内のファイルをコピーする
    var files = sourceFolder.getFiles();
    while (files.hasNext()) {
      var file = files.next();
      Logger.log(file.getName())
      file.makeCopy(file.getName(), newFolder);
    }
  
    // コピー元フォルダ内のサブフォルダを再帰的にコピーする
    var subFolders = sourceFolder.getFolders();
    while (subFolders.hasNext()) {
      var subFolder = subFolders.next();
      Logger.log(subFolder.getName())
      copyFolders(subFolder.getId(), newFolder.getId()); // 修正
    }
  return newFolder.getId()

}
function moveFolders(sourceFolderId, targetFolderId) {
  var sourceFolder = DriveApp.getFolderById(sourceFolderId);
  var targetFolder = DriveApp.getFolderById(targetFolderId);

  // フォルダを移動する
  sourceFolder.moveTo(targetFolder);

  // サブフォルダを再帰的に移動する
  var subFolders = sourceFolder.getFolders();
  while (subFolders.hasNext()) {
    var subFolder = subFolders.next();
    moveFolders(subFolder.getId(), sourceFolder.getId());
  }
}


function main() {

  const PARENT_ID = 'XXXXXXXXXXXXXXXXXXXXXXXXXXXX' // コピー対象のフォルダの親ディレクトリのID
  const DISTINATION_ID = 'XXXXXXXXXXXXXXXXXXXXXXXXXXXX'// コピー先

  // 引数：コピーしたいディレクトリのID、その親ディレクトリのID
  const newid = copyFolders('XXXXXXXXXXXXXXXXXXXXXXXXXXXX', PARENT_ID);
  // newidはコピーされたディレクトリでこれを２番目引数のディレクトリIDに再帰的に移動させる
  moveFolders(newid, DISTINATION_ID)

  Logger.log('タスク：権限の再設定。修正する場合事故りやすいので気を付けること')
  
}