library configuration;

import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';
import 'package:yaml/yaml.dart';

class _SocketServerConfig {
  String protocol, host;
  int port;

  _SocketServerConfig(this.protocol, this.host, this.port);
}

class Configuration {
  _SocketServerConfig socket;
  Configuration.fromMap(Map conf) {
    socket = new _SocketServerConfig(conf['socket']['protocol'],
        conf['socket']['ip'], conf['socket']['port']);
  }
}

@Injectable()
class ConfigurationService {
  Configuration config;

  Future<Configuration> loadConfiguration(Location location) async {
    String protocol = location.protocol;
    String host = location.host.replaceAll(":${window.location.port}", '');
    int port = int.parse(location.port);

    try {
      String configFile = await HttpRequest
          .getString('$protocol//$host:$port/configuration.yaml');

      Map conf = loadYaml(configFile);

      this.config = new Configuration.fromMap(conf['production']);
    } catch (err) {
      print(err);
    }

    return this.config;
  }

  Future<Configuration> getConfiguration(Location location) async {
    if (this.config == null) return this.loadConfiguration(location);
    return this.config;
  }
}
