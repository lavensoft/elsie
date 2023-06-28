class Config {
  static const DEBUG = false;

  //*API
  static const API_VERSION = "v1";
  static const API_HOST = "${DEBUG ? "http://192.168.1.6:9009" : "https://server.elsie.lavenes.com"}/api/$API_VERSION";

  //* TOKENS
  static String MYAP_TOKEN = "_ga=GA1.3.960699633.1673097061; _gid=GA1.3.179218230.1676362027; _gat_gtag_UA_100471794_5=1; PHPSESSID=r8nkviksc7raasr31ldic8ave5; XSRF-TOKEN=eyJpdiI6ImVudUp3MXZCQzhseVMrcXYvYXp5OGc9PSIsInZhbHVlIjoiMTNndms3NWRlZHUwV1p5cXMyUGdvRDZJeHY1M0dTSWh5ZjhYaWxqTHM1NWMySWMzVjkzTDMrZVBNSFdxZHJpU3l4WFZYam13eWZZSmVxYVJnL096MUVWUkVIWVRPZzdPbE45RlRaa1JVL2pDSEVJaTlUWUJxOURwa3NId3I0cWoiLCJtYWMiOiJiOGFkMzgxNjliYTliMzEzNDAxOTA5Zjg3YjYyOTAxY2ZlNzkwODU4YzczZTM3YjA2ZjZiN2RjMTIxZmRkNTIwIiwidGFnIjoiIn0%3D; laravel_session=eyJpdiI6IkZ3VWU5UU12ZkFtKzZWL0t6RFZ2UEE9PSIsInZhbHVlIjoieDU3TzBzZCswQjJJM3NJUXRLaFpNTGNTUDJXaHlCV2JnRExNc1ZYazFZQnFRdzJUR0hSL1Y0ZlMvRXljQ044UFE1bnNOR1E0M2hGdEJQVHJJYjNpVjRBNS80ek5iT0RrLzFiRE5iUTN0NkVvT0ZnSVRiRHJBVExUTXZkTG13MzMiLCJtYWMiOiIzZGE1YWQ4ZjU3Mjk5YWEyN2FhYWY1ZDk1NDJlOTNlZTE0M2Y4MDJhZmI4NjBhMzA4YzUzYmQyZGJlZDA4NWUwIiwidGFnIjoiIn0%3D";
  static String LMS_TOKEN = '_ga=GA1.3.960699633.1673097061; _gid=GA1.3.179218230.1676362027; ilClientId=fpolyhn; PHPSESSID=cs91co54grp63n4q5fkmrlvl72; 1895199927={"any_entry_engaged":true,"tools_engaged":false,"more_available":false,"entries":{"0:0":[0,0,0],"0:1":[0,0,0],"0:1:0":[0,0,0],"0:2":[0,1,0],"0:2:0":[0,0,0],"0:3":[0,0,1]},"tools":{},"known_tools":[],"last_active_top":"0:2"}';
}