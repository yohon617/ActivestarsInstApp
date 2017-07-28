import { Component } from '@angular/core';
import { enableProdMode } from '@angular/core';
import { Router, NavigationStart } from '@angular/router';

enableProdMode();

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {

    public studentLookupActive: boolean;

    title = 'Activstars Instructor App';

    constructor(private router: Router) {
        this.router.events.filter(e => e instanceof NavigationStart)
            .subscribe((e: any) => {
                this.studentLookupActive = e.url.indexOf('studentSearch') > -1 ? true : false;
            });
    }

    public selectStudentSearch(e: any, type: string) {
        e.preventDefault();
        this.router.navigate(['/studentSearch', type]);
    }

}
