import { Component } from '@angular/core';

import { ClassService } from './../services/class/class.service';

@Component({
  selector: 'app-root',
  templateUrl: './report.component.html',
  styleUrls: ['./report.component.css']
})
export class ReportComponent {
    
    constructor(private classService: ClassService) { }

    fileChange(event) {
        this.classService.uploadFile(event.target.files);
    }
}
