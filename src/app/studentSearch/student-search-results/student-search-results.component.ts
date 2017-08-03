import { Component, OnInit, Input } from '@angular/core';

import { Student } from './../../models/student';

@Component({
  selector: 'student-search-results',
  templateUrl: './student-search-results.component.html',
  styleUrls: ['./student-search-results.component.css']
})
export class StudentSearchResultsComponent implements OnInit {

    @Input('studentList') studentList: Student[];

    constructor(
    ) {}

    ngOnInit() {
    }


}
