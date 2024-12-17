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
        supabaseURL: URL(string: "https://dgtyuzggfumsbhbfejfz.supabase.co")!,
        supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImRndHl1emdnZnVtc2JoYmZlamZ6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzQ3NTAzNjgsImV4cCI6MjA1MDMyNjM2OH0.3lsWUfPiL3kSC_jzaKcK0Vy55vu75FXpW_nmUMeHELQ"
    )
}



