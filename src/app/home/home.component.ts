import { Component, OnInit } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';

@Component({
  selector: 'app-home',
  template: `<div>Home</div>`
})
export class HomeComponent implements OnInit {

  constructor(private _http: HttpClient) { }

  ngOnInit() {
    this._http.get('https://localhost:3000/api/OAuth2/token').subscribe(data => {
      console.log('Result of API with absolute URL: ', data);
    });

    this._http.get('./api/Clients?filter[where][userId]=timelyxyz', {
      headers: new HttpHeaders({"Authorization": "CHKNrbjOdZhjv4YWzSPukOOSxGikjvMXDwzId45q"})
    }).subscribe(data => {
      console.log('Result of API with relative URL:', data);
    })
  }


}
