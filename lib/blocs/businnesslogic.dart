class BusinnessLogic {
  double valorEtanol;
  double valorGasolina;

  BusinnessLogic({this.valorEtanol, this.valorGasolina});

  bool etanolCompensa() {
    var result = valorEtanol / valorGasolina;
    return result < 0.7;
  }
}
