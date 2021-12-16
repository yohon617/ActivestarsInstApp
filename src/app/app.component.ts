import { Component, OnInit, TemplateRef } from '@angular/core';
import { enableProdMode } from '@angular/core';
import { Router, NavigationStart } from '@angular/router';

import { BsModalService } from 'ngx-bootstrap/modal';
import { BsModalRef } from 'ngx-bootstrap/modal/modal-options.class';
import { Class } from './models/class';
import { ClassService } from './services/class/class.service';
import { ConfigService } from './config/config.service';

enableProdMode();

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {

    public modalRef: BsModalRef;

    public studentLookupActive: boolean;
    public selectedClass: Class;

    title = 'Activstars Instructor App';

  constructor(private router: Router, private classService: ClassService, private modalService: BsModalService, private config: ConfigService) {
        this.router.events.filter(e => e instanceof NavigationStart)
            .subscribe((e: any) => {
                this.studentLookupActive = e.url.indexOf('studentSearch') > -1 ? true : false;
        });

    }

    ngOnInit(): void {
      this.selectedClass = this.classService.SelectedClass;
    }

    public selectStudentSearch(e: any, type: string) {
        e.preventDefault();
        this.router.navigate(['/studentSearch', type]);
    }


    public openClassEmail(e: any, template: TemplateRef<any>) {
        e.preventDefault();
        this.selectedClass = this.classService.SelectedClass;
        this.modalRef = this.modalService.show(template);
    }
}
