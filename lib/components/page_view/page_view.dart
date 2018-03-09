library page_view_component;

import 'package:angular/angular.dart';

import 'package:honeydew/services.dart' show SocketService;

@Component(
    selector: 'page-view',
    templateUrl: 'page_view.html',
    styleUrls: ['page_view.css'],
    providers: const [SocketService])
class PageViewComponent {
  SocketService socketService;
  PageViewComponent(this.socketService);
}
