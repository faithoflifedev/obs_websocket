enum WebSocketOpCode {
  hello(0),
  identify(1),
  identified(2),
  reIdentify(3),
  event(5),
  request(6),
  requestResponse(7),
  requestBatch(8),
  requestBatchResponse(1);

  final int code;
  const WebSocketOpCode(this.code);
}

enum RequestStatusCode {
  unknown(0),
  noError(10),
  success(100),
  missingRequestType(203),
  unknownRequestType(204),
  genericError(205),
  unsupportedRequestBatchExecutionType(206),
  missingRequestField(300),
  missingRequestData(301),
  invalidRequestField(400),
  invalidRequestFieldType(401),
  requestFieldOutOfRange(402),
  requestFieldEmpty(403),
  tooManyRequestFields(404),
  outputRunning(500),
  outputNotRunning(501),
  outputPaused(502),
  outputNotPaused(505),
  studioModeNotActive(506),
  resourceNotFound(600),
  resourceAlreadyExists(601),
  invalidResourceType(602),
  notEnoughResources(603),
  invalidResourceState(604),
  resourceNotConfigurable(606),
  invalidFilterKind(607),
  resourceCreationFailed(700),
  resourceActionFailed(701),
  requestProcessingFailed(702),
  cannotAct(703);

  final int code;
  const RequestStatusCode(this.code);
}

enum EventSubscription {
  none(0, 'None'),
  general(1, 'General'),
  config(2, 'Config'),
  scenes(4, 'Scenes'),
  inputs(8, 'Inputs'),
  transitions(16, 'Transitions'),
  filters(32, 'Filters'),
  outputs(64, 'Outputs'),
  sceneItems(128, 'SceneItems'),
  mediaInputs(256, 'MediaInputs'),
  vendors(512, 'Vendors'),
  ui(1024, 'Ui'),
  all(2047, 'All'),
  inputVolumeMeters(65536, 'InputVolumeMeters'),
  inputActiveStateChanged(131072, 'InputActiveStateChanged'),
  inputShowStateChanged(262144, 'InputShowStateChanged'),
  sceneItemTransformChanged(524288, 'SceneItemTransformChanged');

  final int code;
  final String name;
  const EventSubscription(this.code, this.name);
}
