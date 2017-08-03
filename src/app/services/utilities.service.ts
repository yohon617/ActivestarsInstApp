import { Injectable } from '@angular/core';
import { RequestOptions, Headers, Http, URLSearchParams } from '@angular/http';


@Injectable()
export class UtilitiesService {
    
    constructor(private http: Http) { }

    private createRequestOptions(method: string, query): RequestOptions {
        let options = new RequestOptions();
        let headers= this.createHeaders(method);
        let params = this.createURLSearchParams(query);
        options.headers = headers;
        options.params = params;
        return options;
    }

    private createHeaders(method) {
        let headers = new Headers();
        if (method === 'post') {
            headers.append('Content-Type', 'application/json');
        }
        return headers;
    }

    private createURLSearchParams(query) {
        let search = new URLSearchParams();
        for (let key in query) {
            if (query[key]) {
                search.set(key, query[key]);
            }
        }
        return search;
    }

    public httpGet(url: string, query = {}) {
        let options: RequestOptions = this.createRequestOptions('get', query);
        return this.http.get(url, options);
    }




}