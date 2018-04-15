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
  String apiVersion;

  Configuration.fromMap(Map conf) {
    this.apiVersion = conf["APIVersion"];

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

    int port;
    if (location.port.isNotEmpty) port = int.parse(location.port);

    String iriOfConfig;
    if (port != null) {
      iriOfConfig = '$protocol//$host:$port/configuration.yaml';
    } else {
      iriOfConfig = '$protocol//$host/configuration.yaml';
    }

    try {
      String configFile = await HttpRequest.getString(iriOfConfig);

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
