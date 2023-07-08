//
//
//

import 'dart:isolate';

void minhaFuncao() {
  print('Executando na nova thread');
}

main() async {
  await Isolate.spawn(minhaFuncao as void Function(dynamic));
  print('Executando na thread principal');
}
