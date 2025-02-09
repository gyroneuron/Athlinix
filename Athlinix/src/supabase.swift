//
//  supabase.swift
//  Athlinix
//
//  Created by Vivek Jaglan on 12/22/24.
//

import Foundation
import Supabase


class SupabaseManager {
    static let shared = SupabaseManager()
    private init() {}
    
    let supabase = SupabaseClient(
        supabaseURL: URL(string: "https://qhucnpudqcnqruhtupjd.supabase.co")!,
        supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFodWNucHVkcWNucXJ1aHR1cGpkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzQ2MjcyMDEsImV4cCI6MjA1MDIwMzIwMX0.oPXYqJZxjjnWt8USBzFWxJQhEjSiZCA4FczGYq82oVM"
    )
}



