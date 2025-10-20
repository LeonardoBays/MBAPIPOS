abstract class DeviceHardwareInfo {
  ///Retorna o modelo do dispositivo, como MOTO G etc
  Future<String> getModel();

  ///Retorna o hardware do dispositivo, ex: qcom(Qualcomm)
  Future<String> getHardware();

  ///Retorna quem monofaturou, ex: Xiaomi
  Future<String> getManufacturer();

  ///Retorna a marca do dispositivo, ex: POCO
  Future<String> getBrand();

  ///Retorna a versão do OS
  Future<String> getOperationalSystem();

  ///Retorna a versão do OS
  Future<int> getApiLevel();
}
