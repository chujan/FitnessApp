//
//  APICallers.swift
//  FitnessApp
//
//  Created by Jennifer Chukwuemeka on 12/12/2023.
//

import Foundation
final class APICaller {
    static let shared = APICaller()
    private init() {}
    func fetchProgramms(completion: @escaping(Result<ExerciseData, Error>) -> Void) {
        let jsonString = """
{
  "exercises": [
            {"name": "Push-up",  "description": "Push-ups are a versatile bodyweight exercise that strengthens the chest, shoulders, triceps, and engages core muscles. This simple and effective exercise builds overall upper body strength. The controlled movement of push-ups targets multiple muscle groups, making it an excellent choice for both beginners and advanced fitness enthusiasts. Variations, such as wide grip or diamond push-ups, can be incorporated to target specific areas of the chest and arms. Including push-ups in your workout routine contributes to muscle endurance, stability, and functional strength.", "imageName": "pushup_image.jpg", "set": 3, "rep": 15, "videoURL": "pushUp.mp4",  "videoFileName": "pushUp", "caloriesBurned": 133, "averageHeartRate": 128, "durationMinutes": 30},
            {"name": "Bench Press", "description": "The bench press is a classic chest exercise that primarily targets the pectoral muscles, shoulders, and triceps. It's a compound movement that allows you to lift heavy weights, promoting muscle growth and strength. Regular inclusion of bench presses in your workout routine helps in developing a well-defined chest and upper body. The bench press can be performed using a barbell or dumbbells, offering variations to suit different preferences and fitness levels. Proper form and technique are essential to maximize the benefits and minimize the risk of injury.", "imageName": "BenchPress_image.jpg", "set": 4, "rep": 12, "videoURL": "BenchPress.mp4",  "videoFileName": "BenchPress", "caloriesBurned": 105, "averageHeartRate": 128, "durationMinutes": 30},
            {"name": "Chest Flyes", "description": "Chest flyes are isolation exercises that specifically target the chest muscles. By focusing on controlled, wide-arm movements, chest flyes help in shaping and defining the chest. They are particularly effective for enhancing chest muscle development and creating a fuller, more sculpted appearance. Performing chest flyes with dumbbells or cables provides constant tension on the chest muscles throughout the range of motion. This exercise can be adjusted to target different areas of the chest, such as the upper or lower regions.", "imageName": "ChestFlyes_image.jpg", "set": 3, "rep": 10, "videoURL": "chestfly.mp4",  "videoFileName": "chestfly", "caloriesBurned": 128, "averageHeartRate": 105, "durationMinutes": 30},
            {"name": "Dumbbell Press", "description": "Dumbbell presses offer a variation to traditional bench presses, allowing for a wider range of motion. This exercise targets the chest, shoulders, and stabilizing muscles. By using dumbbells, each arm works independently, promoting muscle balance and symmetry. Dumbbell presses can be performed on a flat bench, an incline bench, or a decline bench, providing versatility in targeting various areas of the chest. Adjusting the bench angle changes the emphasis on different parts of the pectoral muscles.", "imageName": "DumbbellPress_image.jpg", "set": 3, "rep": 15, "videoURL": "dumbbell.mp4",  "videoFileName": "dumbbell", "caloriesBurned": 122.5, "averageHeartRate": 128, "durationMinutes": 30},
            {"name": "Incline Bench Press", "description": "The incline bench press is a variation of the traditional bench press, with the bench set at an inclined angle. This variation places more emphasis on the upper chest muscles, helping in achieving a balanced and well-developed chest. Including incline bench presses in your workout routine contributes to a comprehensive chest training program and enhances overall upper body strength. The inclined position shifts the workload to the upper chest, creating a more pronounced and sculpted appearance. Proper incline bench press technique involves controlled movement and a stable bench setup.", "imageName": "incline Bench Press_image.jpg", "set": 3, "rep": 12, "videoURL": "inclinebenchpress.mp4",  "videoFileName": "inclinebenchpress", "caloriesBurned": 122.5, "averageHeartRate": 128, "durationMinutes": 30}
  ],
  "workouts": [
    {
      "name": "Full Body Workout",
      "exercises": [
        {"name": "Push-up", "sets": 3, "reps": 15},
        {"name": "Squats", "sets": 3, "reps": 12}
      ]
    },
    {
      "name": "Chest Workout",
      "exercises": [
        {"name": "Bench Press", "sets": 4, "reps": 12},
        {"name": "Flyes", "sets": 3, "reps": 10}
      ]
    },
    {
      "name": "Arms Workout",
      "exercises": [
        {"name": "Bicep Curls", "sets": 3, "reps": 15},
        {"name": "Tricep Dips", "sets": 3, "reps": 12}
      ]
    },
    {
      "name": "Back Workout",
      "exercises": [
        {"name": "Deadlifts", "sets": 4, "reps": 10},
        {"name": "Pull-ups", "sets": 3, "reps": 8}
      ]
    }
  ]
}
"""
        
        do {
            let jsonData = jsonString.data(using: .utf8)!
            let decodedData = try JSONDecoder().decode(ExerciseData.self, from: jsonData)
            
            completion(.success(decodedData))
        } catch {
            completion(.failure(error))
        }
    }
    
    func fetchworkout(completion: @escaping(Result<ExerciseData, Error>) -> Void) {
        let jsonString = """
{
  "exercises": [
        {"name": "Bicep Curls", "type": "Arms", "description": "Bicep Curls are fundamental arm exercises that specifically target the biceps. By isolating the bicep muscles, this exercise helps in building strength, definition, and size in the arms. Bicep Curls are versatile and can be performed with various equipment, including dumbbells, barbells, or cables. Incorporating Bicep Curls into your arm workout routine contributes to well-rounded bicep development. The controlled and deliberate nature of this movement ensures effective muscle engagement and promotes the mind-muscle connection, essential for optimal results. As you lift the weights, focus on the contraction of the biceps, squeezing them at the top of the movement for maximum benefit. Gradually increasing the resistance over time challenges your muscles, fostering continuous growth and improvement in arm strength and aesthetics.", "imageName": "bicep_curls_image.jpg", "set": 3, "rep": 15, "videoURL": "Bicepcurls.mp4",  "videoFileName": "Bicepcurls", "caloriesBurned": 70, "averageHeartRate": 128, "durationMinutes": 30},
        {"name": "Tricep Dips", "type": "Arms", "description": "Tricep Dips are effective exercises for targeting the triceps, the muscles on the back of the arms. This bodyweight exercise engages the triceps, shoulders, and chest, helping in toning and defining the arms. Tricep Dips can be adapted to different fitness levels and are a valuable addition to any arm workout routine, contributing to improved upper body strength and muscle endurance. To perform Tricep Dips, position yourself on parallel bars, lowering your body by bending your elbows and then pushing back up. The controlled descent and ascent target the triceps while also engaging the chest and shoulders. Focus on maintaining proper form to ensure optimal muscle activation. Including Tricep Dips in your routine not only sculpts the triceps but also enhances overall arm aesthetics.", "imageName": "Tricep_Dips_image.jpg", "set": 3, "rep": 12, "videoURL": "Tricepdips.mp4",  "videoFileName": "Tricepdips", "caloriesBurned": 140, "averageHeartRate": 128, "durationMinutes": 30},
        {"name": "Hammer Curls", "type": "Arms", "description": "Hammer Curls are effective for targeting the brachialis, a muscle in the upper arm that lies underneath the biceps. By using a neutral grip, Hammer Curls engage the brachialis and brachioradialis muscles, contributing to overall arm development. This variation provides a unique stimulus to the arms, promoting balanced muscle growth and strength. Hammer Curls are performed by holding dumbbells with a neutral grip and lifting them alternately. The neutral grip shifts the emphasis to the brachialis, promoting balanced arm development. The controlled movement also engages the brachioradialis, contributing to forearm strength. Integrating Hammer Curls into your arm workout routine adds diversity to your training, targeting multiple muscle groups for comprehensive arm development.", "imageName": "Hammer_Curls_image.jpg", "set": 3, "rep": 10, "videoURL": "Hammer.curls.mp4",  "videoFileName": "Hammer.curls", "caloriesBurned": 87.5, "averageHeartRate": 128, "durationMinutes": 30},
        {"name": "Tricep Kickbacks", "type": "Arms", "description": "Tricep Kickbacks are isolation exercises that specifically target the triceps. By extending the arm backward against resistance, this exercise helps in toning and defining the back of the arms. Tricep Kickbacks can be performed with dumbbells and are effective for isolating the triceps, contributing to improved arm aesthetics. To execute Tricep Kickbacks, hinge at the hips, keeping your back straight, and extend the arm backward while holding a dumbbell. This movement isolates the triceps, encouraging muscle engagement and definition. Focus on the full range of motion and control throughout the exercise. Including Tricep Kickbacks in your arm workout routine adds precision to tricep training, contributing to well-defined and sculpted arms.", "imageName": "Tricep_Kickbacks_image.jpg", "set": 3, "rep": 12, "videoURL": "tricepkickbacks.mp4",  "videoFileName": "tricepkickbacks", "caloriesBurned": 105, "averageHeartRate": 128, "durationMinutes": 30},
        {"name": "Chin-Ups", "type": "Arms", "description": "Chin-Ups are compound exercises that primarily target the biceps, back, and shoulders. By lifting your body weight, Chin-Ups are effective for building upper body strength and muscle definition. This bodyweight exercise engages multiple muscle groups, including the lats and traps. Including Chin-Ups in your workout routine contributes to overall upper body strength and enhances functional fitness. Chin-Ups are an excellent choice for those aiming to sculpt and strengthen the arms and back. The wide grip places emphasis on the biceps, promoting bicep activation with each pull-up. Chin-Ups also engage the lats, promoting a V-taper appearance. As a functional movement, Chin-Ups contribute to improved upper body endurance and pulling strength.", "imageName": "Chin-Ups_image.jpg", "set": 3, "rep": 8, "videoURL": "chinup.mp4",  "videoFileName": "chinup", "caloriesBurned": 280, "averageHeartRate": 163, "durationMinutes": 30},
        {"name": "Tricep Dips", "type": "Arms", "description": "Tricep Dips are effective exercises for targeting the triceps, the muscles on the back of the arms. This bodyweight exercise engages the triceps, shoulders, and chest, helping in toning and defining the arms. Tricep Dips can be adapted to different fitness levels and are a valuable addition to any arm workout routine, contributing to improved upper body strength and muscle endurance. To perform Tricep Dips, position yourself on parallel bars, lowering your body by bending your elbows and then pushing back up. The controlled descent and ascent target the triceps while also engaging the chest and shoulders. Focus on maintaining proper form to ensure optimal muscle activation. Including Tricep Dips in your routine not only sculpts the triceps but also enhances overall arm aesthetics.", "imageName": "Tricep_Dips_image.jpg", "set": 3, "rep": 12, "videoURL": "Tricepdips.mp4",  "videoFileName": "Tricepdips", "caloriesBurned": 140, "averageHeartRate": 128, "durationMinutes": 30}
  ],
  "workouts": [
    {
      "name": "Full Body Workout",
      "exercises": [
        {"name": "Push-up", "sets": 3, "reps": 15},
        {"name": "Squats", "sets": 3, "reps": 12}
      ]
    },
    {
      "name": "Chest Workout",
      "exercises": [
        {"name": "Bench Press", "sets": 4, "reps": 12},
        {"name": "Flyes", "sets": 3, "reps": 10}
      ]
    },
    {
      "name": "Arms Workout",
      "exercises": [
        {"name": "Bicep Curls", "sets": 3, "reps": 15},
        {"name": "Tricep Dips", "sets": 3, "reps": 12}
      ]
    },
    {
      "name": "Back Workout",
      "exercises": [
        {"name": "Deadlifts", "sets": 4, "reps": 10},
        {"name": "Pull-ups", "sets": 3, "reps": 8}
      ]
    }
  ]
}
"""
        
        do {
            let jsonData = jsonString.data(using: .utf8)!
            let decodedData = try JSONDecoder().decode(ExerciseData.self, from: jsonData)
            
            completion(.success(decodedData))
        } catch {
            completion(.failure(error))
        }
    }
    
    func getExercise(completion: @escaping(Result<ExerciseData, Error>) -> Void) {
        let jsonString = """
{
  "exercises": [
              {"name": "Running", "description": "Running is a dynamic cardiovascular exercise that engages the entire body. It is an excellent choice for improving cardiovascular health, burning calories, and boosting overall fitness. The rhythmic motion of running activates various muscle groups, including the legs, core, and upper body. It helps enhance endurance, stamina, and lung capacity. Whether you prefer jogging outdoors or running on a treadmill, this versatile exercise can be adapted to different fitness levels. Incorporating running into your workout routine not only contributes to weight management but also provides a natural mood boost, making it an effective and enjoyable form of cardiovascular activity.", "imageName": "Running_image.jpg", "set": 3, "rep": 15, "videoURL": "running.mp4",  "videoFileName": "running", "caloriesBurned": 245, "averageHeartRate": 128, "durationMinutes": 30},
              {"name": "Cycling", "description": "Cycling is a low-impact exercise that offers a range of health benefits. It is particularly effective for building stamina, toning leg muscles, and improving cardiovascular fitness. Cycling can be enjoyed outdoors or indoors on a stationary bike, making it a convenient and enjoyable form of exercise. The repetitive pedaling motion engages the quadriceps, hamstrings, calves, and glutes. Additionally, cycling helps improve joint mobility and reduces the risk of impact-related injuries. Whether you're cycling for leisure, commuting, or as part of a structured workout, it provides an efficient way to burn calories and enhance overall cardiovascular health.", "imageName": "Cycling_image.jpg", "set": 3, "rep": 12, "videoURL": "cycling.mp4",  "videoFileName": "cycling", "caloriesBurned": 280, "averageHeartRate": 128, "durationMinutes": 30},
              {"name": "Jump Rope", "description": "Jump rope exercises are fantastic for cardiovascular fitness, coordination, and calorie burning. This simple yet effective exercise engages multiple muscle groups, including the legs, core, and shoulders. Jumping rope is a versatile workout that can be tailored to different fitness levels. It's an excellent choice for those looking to add variety to their cardio routine while enjoying a fun and challenging workout. The quick, repetitive movements of jumping rope elevate the heart rate, promoting cardiovascular endurance. Jump rope workouts also enhance agility, balance, and footwork. Whether you're a beginner or an experienced fitness enthusiast, incorporating jump rope exercises into your routine adds excitement and intensity to your cardio sessions.", "imageName": "Jump_Rope_image.jpg", "set": 3, "rep": 10, "videoURL": "jumprope.mp4",  "videoFileName": "jumprope", "caloriesBurned": 420, "averageHeartRate": 165, "durationMinutes": 30},
              {"name": "Swimming", "description": "Swimming is a full-body workout that is low-impact on joints and improves cardiovascular health. It engages various muscle groups, including the arms, legs, and core. Swimming is an excellent choice for individuals seeking a refreshing and effective form of exercise. The resistance of the water provides a unique challenge, promoting muscle strength and endurance. Swimming also enhances flexibility, coordination, and lung capacity. Whether you're doing laps in the pool, practicing different strokes, or participating in water aerobics, swimming offers a comprehensive cardiovascular workout. Its low-impact nature makes it suitable for individuals of all ages and fitness levels.", "imageName": "Swimming_image.jpg", "set": 3, "rep": 15, "videoURL": "swimming.mp4",  "videoFileName": "swimming", "caloriesBurned": 245, "averageHeartRate": 128, "durationMinutes": 30},
              {"name": "High-Intensity Interval Training (HIIT)", "description": "High-Intensity Interval Training (HIIT) involves short bursts of intense exercise followed by periods of rest or lower-intensity activity. HIIT is known for its effectiveness in burning fat, boosting metabolism, and improving cardiovascular fitness. It's a time-efficient and challenging workout option. The alternating high and low-intensity intervals keep the heart rate elevated, maximizing calorie burn and cardiovascular benefits. HIIT workouts can be customized with various exercises, including bodyweight movements, cardio exercises, and strength training. The intensity and variability of HIIT make it suitable for individuals looking to optimize their cardiorespiratory fitness in less time. Incorporating HIIT into your routine adds diversity and efficiency to your cardiovascular training.", "imageName": "HIIT_image.jpg", "set": 4, "rep": 10, "videoURL": "Hiit.mp4",  "videoFileName": "Hiit", "caloriesBurned": 350, "averageHeartRate": 163, "durationMinutes": 30}
  ],
  "workouts": [
    {
      "name": "Full Body Workout",
      "exercises": [
        {"name": "Push-up", "sets": 3, "reps": 15},
        {"name": "Squats", "sets": 3, "reps": 12}
      ]
    },
    {
      "name": "Chest Workout",
      "exercises": [
        {"name": "Bench Press", "sets": 4, "reps": 12},
        {"name": "Flyes", "sets": 3, "reps": 10}
      ]
    },
    {
      "name": "Arms Workout",
      "exercises": [
        {"name": "Bicep Curls", "sets": 3, "reps": 15},
        {"name": "Tricep Dips", "sets": 3, "reps": 12}
      ]
    },
    {
      "name": "Back Workout",
      "exercises": [
        {"name": "Deadlifts", "sets": 4, "reps": 10},
        {"name": "Pull-ups", "sets": 3, "reps": 8}
      ]
    }
  ]
}
"""
        
        do {
            let jsonData = jsonString.data(using: .utf8)!
            let decodedData = try JSONDecoder().decode(ExerciseData.self, from: jsonData)
            
            completion(.success(decodedData))
        } catch {
            completion(.failure(error))
        }
    }
   
           
    typealias ExerciseListCompletion = (Result<ExerciseList, Error>) -> Void
    
    func fetchExerciseList(completion: @escaping ExerciseListCompletion) {
        // Replace the URL with your actual API endpoint
        guard let apiUrl = URL(string: "https://wger.de/api/v2/exercisecategory/") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        let task = URLSession.shared.dataTask(with: apiUrl) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data received", code: 1, userInfo: nil)))
                return
            }
            
            do {
                // Decode the JSON response
                let decoder = JSONDecoder()
                let exerciseList = try decoder.decode(ExerciseList.self, from: data)
                
                // Call the completion handler with the decoded result
                completion(.success(exerciseList))
            } catch {
                // Call the completion handler with the decoding error
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
   
    func getExerciseData(completion: @escaping(Result<ExerciseData, Error>) -> Void) {
        let jsonString = """
        {
          "exercises": [
                {"name": "Push-up",  "description": "Push-ups are a versatile bodyweight exercise that strengthens the chest, shoulders, triceps, and engages core muscles. This simple and effective exercise builds overall upper body strength. The controlled movement of push-ups targets multiple muscle groups, making it an excellent choice for both beginners and advanced fitness enthusiasts. Variations, such as wide grip or diamond push-ups, can be incorporated to target specific areas of the chest and arms. Including push-ups in your workout routine contributes to muscle endurance, stability, and functional strength.", "imageName": "pushup_image.jpg", "set": 3, "rep": 15, "videoURL": "pushUp.mp4",  "videoFileName": "pushUp", "caloriesBurned": 133, "averageHeartRate": 128, "durationMinutes": 30},
                {"name": "Incline Bench Press", "description": "The incline bench press is a variation of the traditional bench press, with the bench set at an inclined angle. This variation places more emphasis on the upper chest muscles, helping in achieving a balanced and well-developed chest. Including incline bench presses in your workout routine contributes to a comprehensive chest training program and enhances overall upper body strength. The inclined position shifts the workload to the upper chest, creating a more pronounced and sculpted appearance. Proper incline bench press technique involves controlled movement and a stable bench setup.", "imageName": "incline Bench Press_image.jpg", "set": 3, "rep": 12, "videoURL": "inclinebenchpress.mp4",  "videoFileName": "inclinebenchpress", "caloriesBurned": 122.5, "averageHeartRate": 128, "durationMinutes": 30}
          ],
          "workouts": [
            {
              "name": "Full Body Workout",
              "exercises": [
                {"name": "Push-up", "sets": 3, "reps": 15},
                {"name": "Squats", "sets": 3, "reps": 12}
              ]
            },
            {
              "name": "Chest Workout",
              "exercises": [
                {"name": "Bench Press", "sets": 4, "reps": 12},
                {"name": "Flyes", "sets": 3, "reps": 10}
              ]
            },
            {
              "name": "Arms Workout",
              "exercises": [
                {"name": "Bicep Curls", "sets": 3, "reps": 15},
                {"name": "Tricep Dips", "sets": 3, "reps": 12}
              ]
            },
            {
              "name": "Back Workout",
              "exercises": [
                {"name": "Deadlifts", "sets": 4, "reps": 10},
                {"name": "Pull-ups", "sets": 3, "reps": 8}
              ]
            }
          ]
        }
        """
        
        do {
            let jsonData = jsonString.data(using: .utf8)!
            let decodedData = try JSONDecoder().decode(ExerciseData.self, from: jsonData)
            
            completion(.success(decodedData))
        } catch {
            completion(.failure(error))
        }
    }
    func getShoulders(completion: @escaping(Result<ExerciseData, Error>) -> Void) {
        let jsonString = """
        {
          "exercises": [
            {"name": "Overhead Press", "description": "The Overhead Press is a cornerstone shoulder exercise that plays a pivotal role in developing robust deltoid muscles. By lifting weights directly overhead, this compound movement engages all three heads of the deltoids, promoting balanced shoulder development. Additionally, the trapezius and triceps are activated, providing a comprehensive upper body workout. Including Overhead Press in your routine enhances shoulder strength, stability, and overall muscle definition.", "set": 3, "rep": 10, "imageName": "OverheadPress_image.jpg","videoURL": "overheadpress.mp4",  "videoFileName": "overheadpress", "caloriesBurned": 140, "averageHeartRate": 128, "durationMinutes": 30},
            {"name": "Lateral Raises", "description": "Lateral Raises are focused on isolating the lateral deltoid muscles, responsible for the width and definition of the shoulders. By lifting weights to the sides, away from the body, this exercise effectively targets the outer part of the shoulders. Lateral Raises contribute to achieving that coveted 'V-taper' appearance, enhancing shoulder aesthetics and overall upper body symmetry. Including Lateral Raises in your workout routine accentuates the lateral deltoids, fostering a well-rounded shoulder profile.", "set": 3, "rep": 10, "imageName": "LateralRaises_image.jpg","videoURL": "lateralraises.mp4",  "videoFileName": "lateralraises", "caloriesBurned": 105, "averageHeartRate": 128, "durationMinutes": 30},
            {"name": "Front Raises", "description": "Front Raises concentrate on the anterior deltoid muscles, emphasizing the front shoulders. Lifting weights to the front, this exercise enhances shoulder strength and improves the overall appearance of the shoulders. Front Raises, whether performed with dumbbells or a barbell, contribute to a balanced shoulder routine. By targeting the front deltoids, this exercise complements the lateral and rear deltoid workouts, fostering proportional shoulder development. Including Front Raises in your regimen contributes to a sculpted and well-defined shoulder complex.", "set": 3, "rep": 10, "imageName": "FrontRaises_image.jpg","videoURL": "frontraises.mp4",  "videoFileName": "frontraises", "caloriesBurned": 87.5, "averageHeartRate": 128, "durationMinutes": 30 },
            {"name": "Shrugs", "description": "Shrugs specifically target the upper trapezius muscles, promoting enhanced neck and shoulder development. Lifting the shoulders toward the ears, this exercise effectively engages the upper part of the trapezius. Shrugs contribute to improved shoulder aesthetics and overall upper body symmetry. By adding Shrugs to your routine, you focus on a muscle group often neglected, leading to a well-rounded and sculpted upper body. This exercise is beneficial for individuals seeking a robust and defined neck and shoulder region.", "set": 3, "rep": 10, "imageName": "Shrugs_image.jpg","videoURL": "shrugs.mp4",  "videoFileName": "shrugs", "caloriesBurned": 105, "averageHeartRate": 128, "durationMinutes": 30},
            {"name": "Upright Rows", "description": "Upright Rows are effective for targeting both the trapezius and deltoid muscles, with a primary focus on the upper part of the shoulders and traps. Lifting weights vertically close to the body, this exercise contributes to shoulder definition and upper body strength. Upright Rows are a valuable addition to your shoulder routine, enhancing the development of the trapezius and lateral deltoids. By incorporating Upright Rows, you work towards achieving well-defined shoulders and a powerful upper body aesthetic.", "set": 3, "rep": 10, "imageName": "UprightRows_image.jpg","videoURL": "uprightrows.mp4",  "videoFileName": "uprightrows", "caloriesBurned": 122.5, "averageHeartRate": 128, "durationMinutes": 30},
            {"name": "Shoulder Press", "description": "The Shoulder Press is a fundamental exercise that specifically targets the deltoid muscles. Lifting weights overhead, this compound movement promotes overall shoulder strength and muscle development. The Shoulder Press engages not only the deltoids but also the trapezius and triceps, providing a comprehensive shoulder workout. By including Shoulder Press in your routine, you emphasize the importance of a strong and sculpted shoulder complex. This exercise contributes to enhanced shoulder aesthetics, stability, and functional upper body strength.", "set": 3, "rep": 10, "imageName": "shoulder_press_image.jpg","videoURL": "shoulderpress.mp4",  "videoFileName": "shoulderpress", "caloriesBurned": 140, "averageHeartRate": 128, "durationMinutes": 30}
          ],
          "workouts": [
            {
              "name": "Full Body Workout",
              "exercises": [
                {"name": "Push-up", "sets": 3, "reps": 15},
                {"name": "Squats", "sets": 3, "reps": 12}
              ]
            },
            {
              "name": "Chest Workout",
              "exercises": [
                {"name": "Bench Press", "sets": 4, "reps": 12},
                {"name": "Flyes", "sets": 3, "reps": 10}
              ]
            },
            {
              "name": "Arms Workout",
              "exercises": [
                {"name": "Bicep Curls", "sets": 3, "reps": 15},
                {"name": "Tricep Dips", "sets": 3, "reps": 12}
              ]
            },
            {
              "name": "Back Workout",
              "exercises": [
                {"name": "Deadlifts", "sets": 4, "reps": 10},
                {"name": "Pull-ups", "sets": 3, "reps": 8}
              ]
            }
          ]
        }
        """

        do {
            let jsonData = jsonString.data(using: .utf8)!
            let decodedData = try JSONDecoder().decode(ExerciseData.self, from: jsonData)
            
            completion(.success(decodedData))
        } catch {
            completion(.failure(error))
        }
    }




    func getArms(completion: @escaping(Result<ExerciseData, Error>) -> Void) {
        let jsonString = """
           {
             "exercises": [
               {"name": "Bicep Curls", "type": "Arms", "description": "Bicep Curls are fundamental arm exercises that specifically target the biceps. By isolating the bicep muscles, this exercise helps in building strength, definition, and size in the arms. Bicep Curls are versatile and can be performed with various equipment, including dumbbells, barbells, or cables. Incorporating Bicep Curls into your arm workout routine contributes to well-rounded bicep development. The controlled and deliberate nature of this movement ensures effective muscle engagement and promotes the mind-muscle connection, essential for optimal results. As you lift the weights, focus on the contraction of the biceps, squeezing them at the top of the movement for maximum benefit. Gradually increasing the resistance over time challenges your muscles, fostering continuous growth and improvement in arm strength and aesthetics.", "imageName": "bicep_curls_image.jpg", "set": 3, "rep": 15, "videoURL": "Bicepcurls.mp4",  "videoFileName": "Bicepcurls", "caloriesBurned": 70, "averageHeartRate": 128, "durationMinutes": 30},
               {"name": "Tricep Dips", "type": "Arms", "description": "Tricep Dips are effective exercises for targeting the triceps, the muscles on the back of the arms. This bodyweight exercise engages the triceps, shoulders, and chest, helping in toning and defining the arms. Tricep Dips can be adapted to different fitness levels and are a valuable addition to any arm workout routine, contributing to improved upper body strength and muscle endurance. To perform Tricep Dips, position yourself on parallel bars, lowering your body by bending your elbows and then pushing back up. The controlled descent and ascent target the triceps while also engaging the chest and shoulders. Focus on maintaining proper form to ensure optimal muscle activation. Including Tricep Dips in your routine not only sculpts the triceps but also enhances overall arm aesthetics.", "imageName": "Tricep_Dips_image.jpg", "set": 3, "rep": 12, "videoURL": "Tricepdips.mp4",  "videoFileName": "Tricepdips", "caloriesBurned": 140, "averageHeartRate": 128, "durationMinutes": 30},
               {"name": "Hammer Curls", "type": "Arms", "description": "Hammer Curls are effective for targeting the brachialis, a muscle in the upper arm that lies underneath the biceps. By using a neutral grip, Hammer Curls engage the brachialis and brachioradialis muscles, contributing to overall arm development. This variation provides a unique stimulus to the arms, promoting balanced muscle growth and strength. Hammer Curls are performed by holding dumbbells with a neutral grip and lifting them alternately. The neutral grip shifts the emphasis to the brachialis, promoting balanced arm development. The controlled movement also engages the brachioradialis, contributing to forearm strength. Integrating Hammer Curls into your arm workout routine adds diversity to your training, targeting multiple muscle groups for comprehensive arm development.", "imageName": "Hammer_Curls_image.jpg", "set": 3, "rep": 10, "videoURL": "Hammer.curls.mp4",  "videoFileName": "Hammer.curls", "caloriesBurned": 87.5, "averageHeartRate": 128, "durationMinutes": 30},
               {"name": "Tricep Kickbacks", "type": "Arms", "description": "Tricep Kickbacks are isolation exercises that specifically target the triceps. By extending the arm backward against resistance, this exercise helps in toning and defining the back of the arms. Tricep Kickbacks can be performed with dumbbells and are effective for isolating the triceps, contributing to improved arm aesthetics. To execute Tricep Kickbacks, hinge at the hips, keeping your back straight, and extend the arm backward while holding a dumbbell. This movement isolates the triceps, encouraging muscle engagement and definition. Focus on the full range of motion and control throughout the exercise. Including Tricep Kickbacks in your arm workout routine adds precision to tricep training, contributing to well-defined and sculpted arms.", "imageName": "Tricep_Kickbacks_image.jpg", "set": 3, "rep": 12, "videoURL": "tricepkickbacks.mp4",  "videoFileName": "tricepkickbacks", "caloriesBurned": 105, "averageHeartRate": 128, "durationMinutes": 30},
               {"name": "Chin-Ups", "type": "Arms", "description": "Chin-Ups are compound exercises that primarily target the biceps, back, and shoulders. By lifting your body weight, Chin-Ups are effective for building upper body strength and muscle definition. This bodyweight exercise engages multiple muscle groups, including the lats and traps. Including Chin-Ups in your workout routine contributes to overall upper body strength and enhances functional fitness. Chin-Ups are an excellent choice for those aiming to sculpt and strengthen the arms and back. The wide grip places emphasis on the biceps, promoting bicep activation with each pull-up. Chin-Ups also engage the lats, promoting a V-taper appearance. As a functional movement, Chin-Ups contribute to improved upper body endurance and pulling strength.", "imageName": "Chin-Ups_image.jpg", "set": 3, "rep": 8, "videoURL": "chinup.mp4",  "videoFileName": "chinup", "caloriesBurned": 280, "averageHeartRate": 163, "durationMinutes": 30},
              {"name": "Tricep Dips", "type": "Arms", "description": "Tricep Dips are effective exercises for targeting the triceps, the muscles on the back of the arms. This bodyweight exercise engages the triceps, shoulders, and chest, helping in toning and defining the arms. Tricep Dips can be adapted to different fitness levels and are a valuable addition to any arm workout routine, contributing to improved upper body strength and muscle endurance. To perform Tricep Dips, position yourself on parallel bars, lowering your body by bending your elbows and then pushing back up. The controlled descent and ascent target the triceps while also engaging the chest and shoulders. Focus on maintaining proper form to ensure optimal muscle activation. Including Tricep Dips in your routine not only sculpts the triceps but also enhances overall arm aesthetics.", "imageName": "Tricep_Dips_image.jpg", "set": 3, "rep": 12, "videoURL": "Tricepdips.mp4",  "videoFileName": "Tricepdips", "caloriesBurned": 140, "averageHeartRate": 128, "durationMinutes": 30}

             ],
             "workouts": [
               {
                 "name": "Full Body Workout",
                 "exercises": [
                   {"name": "Push-up", "sets": 3, "reps": 15},
                   {"name": "Squats", "sets": 3, "reps": 12}
                 ]
               },
               {
                 "name": "Chest Workout",
                 "exercises": [
                   {"name": "Bench Press", "sets": 4, "reps": 12},
                   {"name": "Flyes", "sets": 3, "reps": 10}
                 ]
               },
               {
                 "name": "Arms Workout",
                 "exercises": [
                   {"name": "Bicep Curls", "sets": 3, "reps": 15},
                   {"name": "Tricep Dips", "sets": 3, "reps": 12}
                 ]
               },
               {
                 "name": "Back Workout",
                 "exercises": [
                   {"name": "Deadlifts", "sets": 4, "reps": 10},
                   {"name": "Pull-ups", "sets": 3, "reps": 8}
                 ]
               }
             ]
           }
           """

        do {
            let jsonData = jsonString.data(using: .utf8)!
            let decodedData = try JSONDecoder().decode(ExerciseData.self, from: jsonData)
            
            completion(.success(decodedData))
        } catch {
            completion(.failure(error))
        }
    }

       
             
    func getCardio(completion: @escaping(Result<ExerciseData, Error>) -> Void) {
        let jsonString = """
          {
          "exercises": [
            {"name": "Running", "description": "Running is a dynamic cardiovascular exercise that engages the entire body. It is an excellent choice for improving cardiovascular health, burning calories, and boosting overall fitness. The rhythmic motion of running activates various muscle groups, including the legs, core, and upper body. It helps enhance endurance, stamina, and lung capacity. Whether you prefer jogging outdoors or running on a treadmill, this versatile exercise can be adapted to different fitness levels. Incorporating running into your workout routine not only contributes to weight management but also provides a natural mood boost, making it an effective and enjoyable form of cardiovascular activity.", "imageName": "Running_image.jpg", "set": 3, "rep": 15, "videoURL": "running.mp4",  "videoFileName": "running", "caloriesBurned": 245, "averageHeartRate": 128, "durationMinutes": 30},
            {"name": "Cycling", "description": "Cycling is a low-impact exercise that offers a range of health benefits. It is particularly effective for building stamina, toning leg muscles, and improving cardiovascular fitness. Cycling can be enjoyed outdoors or indoors on a stationary bike, making it a convenient and enjoyable form of exercise. The repetitive pedaling motion engages the quadriceps, hamstrings, calves, and glutes. Additionally, cycling helps improve joint mobility and reduces the risk of impact-related injuries. Whether you're cycling for leisure, commuting, or as part of a structured workout, it provides an efficient way to burn calories and enhance overall cardiovascular health.", "imageName": "Cycling_image.jpg", "set": 3, "rep": 12, "videoURL": "cycling.mp4",  "videoFileName": "cycling", "caloriesBurned": 280, "averageHeartRate": 128, "durationMinutes": 30},
            {"name": "Jump Rope", "description": "Jump rope exercises are fantastic for cardiovascular fitness, coordination, and calorie burning. This simple yet effective exercise engages multiple muscle groups, including the legs, core, and shoulders. Jumping rope is a versatile workout that can be tailored to different fitness levels. It's an excellent choice for those looking to add variety to their cardio routine while enjoying a fun and challenging workout. The quick, repetitive movements of jumping rope elevate the heart rate, promoting cardiovascular endurance. Jump rope workouts also enhance agility, balance, and footwork. Whether you're a beginner or an experienced fitness enthusiast, incorporating jump rope exercises into your routine adds excitement and intensity to your cardio sessions.", "imageName": "Jump_Rope_image.jpg", "set": 3, "rep": 10, "videoURL": "jumprope.mp4",  "videoFileName": "jumprope", "caloriesBurned": 420, "averageHeartRate": 165, "durationMinutes": 30},
            {"name": "Swimming", "description": "Swimming is a full-body workout that is low-impact on joints and improves cardiovascular health. It engages various muscle groups, including the arms, legs, and core. Swimming is an excellent choice for individuals seeking a refreshing and effective form of exercise. The resistance of the water provides a unique challenge, promoting muscle strength and endurance. Swimming also enhances flexibility, coordination, and lung capacity. Whether you're doing laps in the pool, practicing different strokes, or participating in water aerobics, swimming offers a comprehensive cardiovascular workout. Its low-impact nature makes it suitable for individuals of all ages and fitness levels.", "imageName": "Swimming_image.jpg", "set": 3, "rep": 15, "videoURL": "swimming.mp4",  "videoFileName": "swimming", "caloriesBurned": 245, "averageHeartRate": 128, "durationMinutes": 30},
            {"name": "High-Intensity Interval Training (HIIT)", "description": "High-Intensity Interval Training (HIIT) involves short bursts of intense exercise followed by periods of rest or lower-intensity activity. HIIT is known for its effectiveness in burning fat, boosting metabolism, and improving cardiovascular fitness. It's a time-efficient and challenging workout option. The alternating high and low-intensity intervals keep the heart rate elevated, maximizing calorie burn and cardiovascular benefits. HIIT workouts can be customized with various exercises, including bodyweight movements, cardio exercises, and strength training. The intensity and variability of HIIT make it suitable for individuals looking to optimize their cardiorespiratory fitness in less time. Incorporating HIIT into your routine adds diversity and efficiency to your cardiovascular training.", "imageName": "HIIT_image.jpg", "set": 4, "rep": 10, "videoURL": "Hiit.mp4",  "videoFileName": "Hiit", "caloriesBurned": 350, "averageHeartRate": 163, "durationMinutes": 30}
          ],
          "workouts": [
            {
              "name": "Full Body Workout",
              "exercises": [
                {"name": "Push-up", "sets": 3, "reps": 15},
                {"name": "Squats", "sets": 3, "reps": 12}
              ]
            },
            {
              "name": "Chest Workout",
              "exercises": [
                {"name": "Bench Press", "sets": 4, "reps": 12},
                {"name": "Flyes", "sets": 3, "reps": 10}
              ]
            },
            {
              "name": "Arms Workout",
              "exercises": [
                {"name": "Bicep Curls", "sets": 3, "reps": 15},
                {"name": "Tricep Dips", "sets": 3, "reps": 12}
              ]
            },
            {
              "name": "Back Workout",
              "exercises": [
                {"name": "Deadlifts", "sets": 4, "reps": 10},
                {"name": "Pull-ups", "sets": 3, "reps": 8}
              ]
            }
          ]
        }
        """
        
        do {
            let jsonData = jsonString.data(using: .utf8)!
            let decodedData = try JSONDecoder().decode(ExerciseData.self, from: jsonData)
            
            completion(.success(decodedData))
        } catch {
            completion(.failure(error))
        }
    }

    func getChest(completion: @escaping(Result<ExerciseData, Error>) -> Void) {
        let jsonString = """
        {
            "exercises": [
                {"name": "Push-up",  "description": "Push-ups are a versatile bodyweight exercise that strengthens the chest, shoulders, triceps, and engages core muscles. This simple and effective exercise builds overall upper body strength. The controlled movement of push-ups targets multiple muscle groups, making it an excellent choice for both beginners and advanced fitness enthusiasts. Variations, such as wide grip or diamond push-ups, can be incorporated to target specific areas of the chest and arms. Including push-ups in your workout routine contributes to muscle endurance, stability, and functional strength.", "imageName": "pushup_image.jpg", "set": 3, "rep": 15, "videoURL": "pushUp.mp4",  "videoFileName": "pushUp", "caloriesBurned": 133, "averageHeartRate": 128, "durationMinutes": 30},
                {"name": "Bench Press", "description": "The bench press is a classic chest exercise that primarily targets the pectoral muscles, shoulders, and triceps. It's a compound movement that allows you to lift heavy weights, promoting muscle growth and strength. Regular inclusion of bench presses in your workout routine helps in developing a well-defined chest and upper body. The bench press can be performed using a barbell or dumbbells, offering variations to suit different preferences and fitness levels. Proper form and technique are essential to maximize the benefits and minimize the risk of injury.", "imageName": "BenchPress_image.jpg", "set": 4, "rep": 12, "videoURL": "BenchPress.mp4",  "videoFileName": "BenchPress", "caloriesBurned": 105, "averageHeartRate": 128, "durationMinutes": 30},
                {"name": "Chest Flyes", "description": "Chest flyes are isolation exercises that specifically target the chest muscles. By focusing on controlled, wide-arm movements, chest flyes help in shaping and defining the chest. They are particularly effective for enhancing chest muscle development and creating a fuller, more sculpted appearance. Performing chest flyes with dumbbells or cables provides constant tension on the chest muscles throughout the range of motion. This exercise can be adjusted to target different areas of the chest, such as the upper or lower regions.", "imageName": "ChestFlyes_image.jpg", "set": 3, "rep": 10, "videoURL": "chestfly.mp4",  "videoFileName": "chestfly", "caloriesBurned": 128, "averageHeartRate": 105, "durationMinutes": 30},
                {"name": "Dumbbell Press", "description": "Dumbbell presses offer a variation to traditional bench presses, allowing for a wider range of motion. This exercise targets the chest, shoulders, and stabilizing muscles. By using dumbbells, each arm works independently, promoting muscle balance and symmetry. Dumbbell presses can be performed on a flat bench, an incline bench, or a decline bench, providing versatility in targeting various areas of the chest. Adjusting the bench angle changes the emphasis on different parts of the pectoral muscles.", "imageName": "DumbbellPress_image.jpg", "set": 3, "rep": 15, "videoURL": "dumbbell.mp4",  "videoFileName": "dumbbell", "caloriesBurned": 122.5, "averageHeartRate": 128, "durationMinutes": 30},
                {"name": "Incline Bench Press", "description": "The incline bench press is a variation of the traditional bench press, with the bench set at an inclined angle. This variation places more emphasis on the upper chest muscles, helping in achieving a balanced and well-developed chest. Including incline bench presses in your workout routine contributes to a comprehensive chest training program and enhances overall upper body strength. The inclined position shifts the workload to the upper chest, creating a more pronounced and sculpted appearance. Proper incline bench press technique involves controlled movement and a stable bench setup.", "imageName": "incline Bench Press_image.jpg", "set": 3, "rep": 12, "videoURL": "inclinebenchpress.mp4",  "videoFileName": "inclinebenchpress", "caloriesBurned": 122.5, "averageHeartRate": 128, "durationMinutes": 30}
            ],
            "workouts": [
                {
                    "name": "Full Body Workout",
                    "exercises": [
                        {"name": "Push-up", "sets": 3, "reps": 15},
                        {"name": "Squats", "sets": 3, "reps": 12}
                    ]
                },
                {
                    "name": "Chest Workout",
                    "exercises": [
                        {"name": "Bench Press", "sets": 4, "reps": 12},
                        {"name": "Flyes", "sets": 3, "reps": 10}
                    ]
                },
                {
                    "name": "Arms Workout",
                    "exercises": [
                        {"name": "Bicep Curls", "sets": 3, "reps": 15},
                        {"name": "Tricep Dips", "sets": 3, "reps": 12}
                    ]
                },
                {
                    "name": "Back Workout",
                    "exercises": [
                        {"name": "Deadlifts", "sets": 4, "reps": 10},
                        {"name": "Pull-ups", "sets": 3, "reps": 8}
                    ]
                }
            ]
        }
        """
        
        do {
            let jsonData = jsonString.data(using: .utf8)!
            let decodedData = try JSONDecoder().decode(ExerciseData.self, from: jsonData)
            
            completion(.success(decodedData))
        } catch {
            completion(.failure(error))
        }
    }

           
  
    
    func getAlltypes(completion: @escaping(Result<ExerciseData, Error>) -> Void) {
        let jsonString = """
        {
        "exercises": [
        {"name": "Overhead Press", "type": "Shoulders", "description": "The Overhead Press is a cornerstone shoulder exercise that plays a pivotal role in developing robust deltoid muscles. By lifting weights directly overhead, this compound movement engages all three heads of the deltoids, promoting balanced shoulder development. Additionally, the trapezius and triceps are activated, providing a comprehensive upper body workout. Including Overhead Press in your routine enhances shoulder strength, stability, and overall muscle definition.", "set": 3, "rep": 10, "imageName": "OverheadPress_image.jpg","videoURL": "overheadpress.mp4",  "videoFileName": "overheadpress", "caloriesBurned": 140, "averageHeartRate": 128, "durationMinutes": 30},
        {"name": "Lateral Raises", "type": "Shoulders", "description": "Lateral Raises are focused on isolating the lateral deltoid muscles, responsible for the width and definition of the shoulders. By lifting weights to the sides, away from the body, this exercise effectively targets the outer part of the shoulders. Lateral Raises contribute to achieving that coveted 'V-taper' appearance, enhancing shoulder aesthetics and overall upper body symmetry. Including Lateral Raises in your workout routine accentuates the lateral deltoids, fostering a well-rounded shoulder profile.", "set": 3, "rep": 10, "imageName": "LateralRaises_image.jpg","videoURL": "lateralraises.mp4",  "videoFileName": "lateralraises", "caloriesBurned": 105, "averageHeartRate": 128, "durationMinutes": 30},
        {"name": "Front Raises", "type": "Shoulders","description": "Front Raises concentrate on the anterior deltoid muscles, emphasizing the front shoulders. Lifting weights to the front, this exercise enhances shoulder strength and improves the overall appearance of the shoulders. Front Raises, whether performed with dumbbells or a barbell, contribute to a balanced shoulder routine. By targeting the front deltoids, this exercise complements the lateral and rear deltoid workouts, fostering proportional shoulder development. Including Front Raises in your regimen contributes to a sculpted and well-defined shoulder complex.", "set": 3, "rep": 10, "imageName": "FrontRaises_image.jpg","videoURL": "frontraises.mp4",  "videoFileName": "frontraises", "caloriesBurned": 87.5, "averageHeartRate": 128, "durationMinutes": 30 },
        {"name": "Shrugs", "type": "Shoulders", "description": "Shrugs specifically target the upper trapezius muscles, promoting enhanced neck and shoulder development. Lifting the shoulders toward the ears, this exercise effectively engages the upper part of the trapezius. Shrugs contribute to improved shoulder aesthetics and overall upper body symmetry. By adding Shrugs to your routine, you focus on a muscle group often neglected, leading to a well-rounded and sculpted upper body. This exercise is beneficial for individuals seeking a robust and defined neck and shoulder region.", "set": 3, "rep": 10, "imageName": "Shrugs_image.jpg","videoURL": "shrugs.mp4",  "videoFileName": "shrugs", "caloriesBurned": 105, "averageHeartRate": 128, "durationMinutes": 30},
        {"name": "Upright Rows", "type": "Shoulders", "description": "Upright Rows are effective for targeting both the trapezius and deltoid muscles, with a primary focus on the upper part of the shoulders and traps. Lifting weights vertically close to the body, this exercise contributes to shoulder definition and upper body strength. Upright Rows are a valuable addition to your shoulder routine, enhancing the development of the trapezius and lateral deltoids. By incorporating Upright Rows, you work towards achieving well-defined shoulders and a powerful upper body aesthetic.", "set": 3, "rep": 10, "imageName": "UprightRows_image.jpg","videoURL": "uprightrows.mp4",  "videoFileName": "uprightrows", "caloriesBurned": 122.5, "averageHeartRate": 128, "durationMinutes": 30},
        {"name": "Shoulder Press", "type": "Shoulders", "description": "The Shoulder Press is a fundamental exercise that specifically targets the deltoid muscles. Lifting weights overhead, this compound movement promotes overall shoulder strength and muscle development. The Shoulder Press engages not only the deltoids but also the trapezius and triceps, providing a comprehensive shoulder workout. By including Shoulder Press in your routine, you emphasize the importance of a strong and sculpted shoulder complex. This exercise contributes to enhanced shoulder aesthetics, stability, and functional upper body strength.", "set": 3, "rep": 10, "imageName": "shoulder_press_image.jpg","videoURL": "shoulderpress.mp4",  "videoFileName": "shoulderpress", "caloriesBurned": 140, "averageHeartRate": 128, "durationMinutes": 30},
        {"name": "Bicep Curls", "type": "Arms", "description": "Bicep Curls are fundamental arm exercises that specifically target the biceps. By isolating the bicep muscles, this exercise helps in building strength, definition, and size in the arms. Bicep Curls are versatile and can be performed with various equipment, including dumbbells, barbells, or cables. Incorporating Bicep Curls into your arm workout routine contributes to well-rounded bicep development. The controlled and deliberate nature of this movement ensures effective muscle engagement and promotes the mind-muscle connection, essential for optimal results. As you lift the weights, focus on the contraction of the biceps, squeezing them at the top of the movement for maximum benefit. Gradually increasing the resistance over time challenges your muscles, fostering continuous growth and improvement in arm strength and aesthetics.", "imageName": "bicep_curls_image.jpg", "set": 3, "rep": 15, "videoURL": "Bicepcurls.mp4",  "videoFileName": "Bicepcurls", "caloriesBurned": 70, "averageHeartRate": 128, "durationMinutes": 30},
        {"name": "Tricep Dips", "type": "Arms", "description": "Tricep Dips are effective exercises for targeting the triceps, the muscles on the back of the arms. This bodyweight exercise engages the triceps, shoulders, and chest, helping in toning and defining the arms. Tricep Dips can be adapted to different fitness levels and are a valuable addition to any arm workout routine, contributing to improved upper body strength and muscle endurance. To perform Tricep Dips, position yourself on parallel bars, lowering your body by bending your elbows and then pushing back up. The controlled descent and ascent target the triceps while also engaging the chest and shoulders. Focus on maintaining proper form to ensure optimal muscle activation. Including Tricep Dips in your routine not only sculpts the triceps but also enhances overall arm aesthetics.", "imageName": "Tricep_Dips_image.jpg", "set": 3, "rep": 12, "videoURL": "Tricepdips.mp4",  "videoFileName": "Tricepdips", "caloriesBurned": 140, "averageHeartRate": 128, "durationMinutes": 30},
        {"name": "Hammer Curls", "type": "Arms", "description": "Hammer Curls are effective for targeting the brachialis, a muscle in the upper arm that lies underneath the biceps. By using a neutral grip, Hammer Curls engage the brachialis and brachioradialis muscles, contributing to overall arm development. This variation provides a unique stimulus to the arms, promoting balanced muscle growth and strength. Hammer Curls are performed by holding dumbbells with a neutral grip and lifting them alternately. The neutral grip shifts the emphasis to the brachialis, promoting balanced arm development. The controlled movement also engages the brachioradialis, contributing to forearm strength. Integrating Hammer Curls into your arm workout routine adds diversity to your training, targeting multiple muscle groups for comprehensive arm development.", "imageName": "Hammer_Curls_image.jpg", "set": 3, "rep": 10, "videoURL": "Hammer.curls.mp4",  "videoFileName": "Hammer.curls", "caloriesBurned": 87.5, "averageHeartRate": 128, "durationMinutes": 30},
        {"name": "Tricep Kickbacks", "type": "Arms", "description": "Tricep Kickbacks are isolation exercises that specifically target the triceps. By extending the arm backward against resistance, this exercise helps in toning and defining the back of the arms. Tricep Kickbacks can be performed with dumbbells and are effective for isolating the triceps, contributing to improved arm aesthetics. To execute Tricep Kickbacks, hinge at the hips, keeping your back straight, and extend the arm backward while holding a dumbbell. This movement isolates the triceps, encouraging muscle engagement and definition. Focus on the full range of motion and control throughout the exercise. Including Tricep Kickbacks in your arm workout routine adds precision to tricep training, contributing to well-defined and sculpted arms.", "imageName": "Tricep_Kickbacks_image.jpg", "set": 3, "rep": 12, "videoURL": "tricepkickbacks.mp4",  "videoFileName": "tricepkickbacks", "caloriesBurned": 105, "averageHeartRate": 128, "durationMinutes": 30},
        {"name": "Chin-Ups", "type": "Arms", "description": "Chin-Ups are compound exercises that primarily target the biceps, back, and shoulders. By lifting your body weight, Chin-Ups are effective for building upper body strength and muscle definition. This bodyweight exercise engages multiple muscle groups, including the lats and traps. Including Chin-Ups in your workout routine contributes to overall upper body strength and enhances functional fitness. Chin-Ups are an excellent choice for those aiming to sculpt and strengthen the arms and back. The wide grip places emphasis on the biceps, promoting bicep activation with each pull-up. Chin-Ups also engage the lats, promoting a V-taper appearance. As a functional movement, Chin-Ups contribute to improved upper body endurance and pulling strength.", "imageName": "Chin-Ups_image.jpg", "set": 3, "rep": 8, "videoURL": "chinup.mp4",  "videoFileName": "chinup", "caloriesBurned": 280, "averageHeartRate": 163, "durationMinutes": 30},
        {"name": "Tricep Dips", "type": "Arms", "description": "Tricep Dips are effective exercises for targeting the triceps, the muscles on the back of the arms. This bodyweight exercise engages the triceps, shoulders, and chest, helping in toning and defining the arms. Tricep Dips can be adapted to different fitness levels and are a valuable addition to any arm workout routine, contributing to improved upper body strength and muscle endurance. To perform Tricep Dips, position yourself on parallel bars, lowering your body by bending your elbows and then pushing back up. The controlled descent and ascent target the triceps while also engaging the chest and shoulders. Focus on maintaining proper form to ensure optimal muscle activation. Including Tricep Dips in your routine not only sculpts the triceps but also enhances overall arm aesthetics.", "imageName": "Tricep_Dips_image.jpg", "set": 3, "rep": 12, "videoURL": "Tricepdips.mp4",  "videoFileName": "Tricepdips", "caloriesBurned": 140, "averageHeartRate": 128, "durationMinutes": 30},
        {"name": "Running", "type": "Cardio", "description": "Running is a dynamic cardiovascular exercise that engages the entire body. It is an excellent choice for improving cardiovascular health, burning calories, and boosting overall fitness. The rhythmic motion of running activates various muscle groups, including the legs, core, and upper body. It helps enhance endurance, stamina, and lung capacity. Whether you prefer jogging outdoors or running on a treadmill, this versatile exercise can be adapted to different fitness levels. Incorporating running into your workout routine not only contributes to weight management but also provides a natural mood boost, making it an effective and enjoyable form of cardiovascular activity.", "imageName": "Running_image.jpg", "set": 3, "rep": 15, "videoURL": "running.mp4",  "videoFileName": "running", "caloriesBurned": 245, "averageHeartRate": 128, "durationMinutes": 30},
        {"name": "Cycling", "type": "Cardio", "description": "Cycling is a low-impact exercise that offers a range of health benefits. It is particularly effective for building stamina, toning leg muscles, and improving cardiovascular fitness. Cycling can be enjoyed outdoors or indoors on a stationary bike, making it a convenient and enjoyable form of exercise. The repetitive pedaling motion engages the quadriceps, hamstrings, calves, and glutes. Additionally, cycling helps improve joint mobility and reduces the risk of impact-related injuries. Whether you're cycling for leisure, commuting, or as part of a structured workout, it provides an efficient way to burn calories and enhance overall cardiovascular health.", "imageName": "Cycling_image.jpg", "set": 3, "rep": 12, "videoURL": "cycling.mp4",  "videoFileName": "cycling", "caloriesBurned": 280, "averageHeartRate": 128, "durationMinutes": 30},
        {"name": "Jump Rope", "type": "Cardio", "description": "Jump rope exercises are fantastic for cardiovascular fitness, coordination, and calorie burning. This simple yet effective exercise engages multiple muscle groups, including the legs, core, and shoulders. Jumping rope is a versatile workout that can be tailored to different fitness levels. It's an excellent choice for those looking to add variety to their cardio routine while enjoying a fun and challenging workout. The quick, repetitive movements of jumping rope elevate the heart rate, promoting cardiovascular endurance. Jump rope workouts also enhance agility, balance, and footwork. Whether you're a beginner or an experienced fitness enthusiast, incorporating jump rope exercises into your routine adds excitement and intensity to your cardio sessions.", "imageName": "Jump_Rope_image.jpg", "set": 3, "rep": 10, "videoURL": "jumprope.mp4",  "videoFileName": "jumprope", "caloriesBurned": 420, "averageHeartRate": 165, "durationMinutes": 30},
        {"name": "Swimming", "type": "Cardio", "description": "Swimming is a full-body workout that is low-impact on joints and improves cardiovascular health. It engages various muscle groups, including the arms, legs, and core. Swimming is an excellent choice for individuals seeking a refreshing and effective form of exercise. The resistance of the water provides a unique challenge, promoting muscle strength and endurance. Swimming also enhances flexibility, coordination, and lung capacity. Whether you're doing laps in the pool, practicing different strokes, or participating in water aerobics, swimming offers a comprehensive cardiovascular workout. Its low-impact nature makes it suitable for individuals of all ages and fitness levels.", "imageName": "Swimming_image.jpg", "set": 3, "rep": 15, "videoURL": "swimming.mp4",  "videoFileName": "swimming", "caloriesBurned": 245, "averageHeartRate": 128, "durationMinutes": 30},
        {"name": "High-Intensity Interval Training (HIIT)", "type": "Cardio", "description": "High-Intensity Interval Training (HIIT) involves short bursts of intense exercise followed by periods of rest or lower-intensity activity. HIIT is known for its effectiveness in burning fat, boosting metabolism, and improving cardiovascular fitness. It's a time-efficient and challenging workout option. The alternating high and low-intensity intervals keep the heart rate elevated, maximizing calorie burn and cardiovascular benefits. HIIT workouts can be customized with various exercises, including bodyweight movements, cardio exercises, and strength training. The intensity and variability of HIIT make it suitable for individuals looking to optimize their cardiorespiratory fitness in less time. Incorporating HIIT into your routine adds diversity and efficiency to your cardiovascular training.", "imageName": "HIIT_image.jpg", "set": 4, "rep": 10, "videoURL": "Hiit.mp4",  "videoFileName": "Hiit", "caloriesBurned": 350, "averageHeartRate": 163, "durationMinutes": 30},
        {"name": "Push-up", "type": "Chest", "description": "Push-ups are a versatile bodyweight exercise that strengthens the chest, shoulders, triceps, and engages core muscles. This simple and effective exercise builds overall upper body strength. The controlled movement of push-ups targets multiple muscle groups, making it an excellent choice for both beginners and advanced fitness enthusiasts. Variations, such as wide grip or diamond push-ups, can be incorporated to target specific areas of the chest and arms. Including push-ups in your workout routine contributes to muscle endurance, stability, and functional strength.", "imageName": "pushup_image.jpg", "set": 3, "rep": 15, "videoURL": "pushUp.mp4",  "videoFileName": "pushUp", "caloriesBurned": 133, "averageHeartRate": 128, "durationMinutes": 30},
        {"name": "Bench Press", "type": "Chest", "description": "The bench press is a classic chest exercise that primarily targets the pectoral muscles, shoulders, and triceps. It's a compound movement that allows you to lift heavy weights, promoting muscle growth and strength. Regular inclusion of bench presses in your workout routine helps in developing a well-defined chest and upper body. The bench press can be performed using a barbell or dumbbells, offering variations to suit different preferences and fitness levels. Proper form and technique are essential to maximize the benefits and minimize the risk of injury.", "imageName": "BenchPress_image.jpg", "set": 4, "rep": 12, "videoURL": "BenchPress.mp4",  "videoFileName": "BenchPress", "caloriesBurned": 105, "averageHeartRate": 128, "durationMinutes": 30},
        {"name": "Chest Flyes", "type": "Chest", "description": "Chest flyes are isolation exercises that specifically target the chest muscles. By focusing on controlled, wide-arm movements, chest flyes help in shaping and defining the chest. They are particularly effective for enhancing chest muscle development and creating a fuller, more sculpted appearance. Performing chest flyes with dumbbells or cables provides constant tension on the chest muscles throughout the range of motion. This exercise can be adjusted to target different areas of the chest, such as the upper or lower regions.", "imageName": "ChestFlyes_image.jpg", "set": 3, "rep": 10, "videoURL": "chestfly.mp4",  "videoFileName": "chestfly", "caloriesBurned": 128, "averageHeartRate": 105, "durationMinutes": 30},
        {"name": "Dumbbell Press", "type": "Chest", "description": "Dumbbell presses offer a variation to traditional bench presses, allowing for a wider range of motion. This exercise targets the chest, shoulders, and stabilizing muscles. By using dumbbells, each arm works independently, promoting muscle balance and symmetry. Dumbbell presses can be performed on a flat bench, an incline bench, or a decline bench, providing versatility in targeting various areas of the chest. Adjusting the bench angle changes the emphasis on different parts of the pectoral muscles.", "imageName": "DumbbellPress_image.jpg", "set": 3, "rep": 15, "videoURL": "dumbbell.mp4",  "videoFileName": "dumbbell", "caloriesBurned": 122.5, "averageHeartRate": 128, "durationMinutes": 30},
        {"name": "Incline Bench Press", "type": "Chest", "description": "The incline bench press is a variation of the traditional bench press, with the bench set at an inclined angle. This variation places more emphasis on the upper chest muscles, helping in achieving a balanced and well-developed chest. Including incline bench presses in your workout routine contributes to a comprehensive chest training program and enhances overall upper body strength. The inclined position shifts the workload to the upper chest, creating a more pronounced and sculpted appearance. Proper incline bench press technique involves controlled movement and a stable bench setup.", "imageName": "incline Bench Press_image.jpg", "set": 3, "rep": 12, "videoURL": "inclinebenchpress.mp4",  "videoFileName": "inclinebenchpress", "caloriesBurned": 122.5, "averageHeartRate": 128, "durationMinutes": 30}
              ],
          "workouts": [
            {
              "name": "Full Body Workout",
              "exercises": [
                {"name": "Push-up", "sets": 3, "reps": 15},
                {"name": "Squats", "sets": 3, "reps": 12}
              ]
            },
            {
              "name": "Chest Workout",
              "exercises": [
                {"name": "Bench Press", "sets": 4, "reps": 12},
                {"name": "Flyes", "sets": 3, "reps": 10}
              ]
            },
            {
              "name": "Arms Workout",
              "exercises": [
                {"name": "Bicep Curls", "sets": 3, "reps": 15},
                {"name": "Tricep Dips", "sets": 3, "reps": 12}
              ]
            },
            {
              "name": "Back Workout",
              "exercises": [
                {"name": "Deadlifts", "sets": 4, "reps": 10},
                {"name": "Pull-ups", "sets": 3, "reps": 8}
              ]
            }
          ]
        }
        """
        
        do {
            let jsonData = jsonString.data(using: .utf8)!
            let decodedData = try JSONDecoder().decode(ExerciseData.self, from: jsonData)
            
            completion(.success(decodedData))
        } catch {
            completion(.failure(error))
        }
    }
    func getWorkoutSummary(completion: @escaping (Result<ExerciseData, Error>) -> Void) {
        let jsonString = """
            {
              "exercises": [
                {"name": "Shoulders", "description": "Upper body exercise", "imageName": "figure.strengthtraining.traditional"},
                {"name": "Arms", "description": "Lower body exercise", "imageName": "figure.yoga"},
                {"name": "Cardio", "description": "Leg exercise", "imageName": "bolt.heart"},
                {"name": "Chest", "description": "Full body exercise", "imageName": "figure.play"}
              ],
              "workouts": [
                {
                  "name": "Full Body Workout",
                  "exercises": [
                    {"name": "Push-up", "sets": 3, "reps": 15},
                    {"name": "Squats", "sets": 3, "reps": 12}
                  ]
                },
                {
                  "name": "Chest Workout",
                  "exercises": [
                    {"name": "Bench Press", "sets": 4, "reps": 12},
                    {"name": "Flyes", "sets": 3, "reps": 10}
                  ]
                },
                {
                  "name": "Arms Workout",
                  "exercises": [
                    {"name": "Bicep Curls", "sets": 3, "reps": 15},
                    {"name": "Tricep Dips", "sets": 3, "reps": 12}
                  ]
                },
                {
                  "name": "Back Workout",
                  "exercises": [
                    {"name": "Deadlifts", "sets": 4, "reps": 10},
                    {"name": "Pull-ups", "sets": 3, "reps": 8}
                  ]
                }
              ]
            }
            """

        do {
            let jsonData = jsonString.data(using: .utf8)!
            let decodedData = try JSONDecoder().decode(ExerciseData.self, from: jsonData)

            completion(.success(decodedData))
        } catch {
            completion(.failure(error))
        }
    }
    func getUniversal(completion: @escaping (Result<NutritionData, Error>) -> Void) {
        let jsonString = """
        {
            "nutrition": [
                {
                    "category": "Universal",
                    "description":  "For daily nutrition",
                    "foods": [
                        {
                            "name": "Mixed Vegetable Stir-Fry",
                            "description": "Assorted vegetables sautéed in olive oil.",
                            "ingredients": ["Broccoli", "Bell peppers", "Carrots", "Zucchini", "Olive oil", "Garlic", "Salt", "Pepper"],
                            "instructions": "1. Heat olive oil in a pan and sauté minced garlic until fragrant.\\n2. Add chopped broccoli, bell peppers, carrots, and zucchini.\\n3. Stir-fry until the vegetables are tender yet crisp.\\n4. Season with salt and pepper to taste.",
                            "kcal": 300,
                            "time": 20,
                            "imageName": "Mixed_Vegetable_image.jpg"
                        },
                        {
                            "name": "Quinoa Salad with Chickpeas",
                            "description": "Quinoa mixed with chickpeas, cherry tomatoes, cucumber, and a lemon vinaigrette.",
                            "ingredients": ["Quinoa", "Chickpeas", "Cherry tomatoes", "Cucumber", "Lemon", "Olive oil", "Salt", "Pepper"],
                            "instructions": "1. Cook quinoa according to package instructions.\\n2. In a bowl, combine cooked quinoa, chickpeas, halved cherry tomatoes, and diced cucumber.\\n3. In a separate bowl, whisk together lemon juice, olive oil, salt, and pepper to create the vinaigrette.\\n4. Pour the vinaigrette over the quinoa mixture and toss to combine.",
                            "kcal": 250,
                            "time": 15,
                            "imageName": "Quinoa_salad_image.jpg"
                        },
                        {
                            "name": "Grilled Chicken Breast",
                            "description": "Lean protein source seasoned and grilled.",
                            "ingredients": ["Chicken breast", "Olive oil", "Lemon", "Garlic", "Salt", "Pepper"],
                            "instructions": "1. Preheat the grill or grill pan.\\n2. In a bowl, mix olive oil, lemon juice, minced garlic, salt, and pepper to create a marinade.\\n3. Coat chicken breasts with the marinade.\\n4. Grill the chicken until cooked through, about 6-8 minutes per side.",
                            "kcal": 350,
                            "time": 25,
                           "imageName": "chicken_breast_image.jpg"
                        },
                        {
                            "name": "Salmon and Avocado Wrap",
                            "description": "Whole grain wrap with grilled salmon, avocado, and leafy greens.",
                            "ingredients": ["Salmon fillet", "Whole grain wrap", "Avocado", "Leafy greens", "Lemon", "Salt", "Pepper"],
                            "instructions": "1. Season the salmon fillet with salt, pepper, and a squeeze of lemon juice.\\n2. Grill or bake the salmon until it flakes easily.\\n3. Spread mashed avocado on a whole grain wrap.\\n4. Place grilled salmon and leafy greens on the wrap.\\n5. Roll it up and enjoy.",
                            "kcal": 400,
                            "time": 30,
                            "imageName": "Salmon_image.jpg"
                        },
                        {
                            "name": "Brown Rice and Black Bean Bowl",
                            "description": "Brown rice topped with black beans, corn, salsa, and cilantro.",
                            "ingredients": ["Brown rice", "Black beans", "Corn", "Salsa", "Cilantro", "Lime", "Salt", "Pepper"],
                            "instructions": "1. Cook brown rice according to package instructions.\\n2. In a bowl, combine cooked brown rice, black beans, corn, salsa, chopped cilantro, and a squeeze of lime.\\n3. Season with salt and pepper to taste.\\n4. Mix well and serve.",
                            "kcal": 400,
                            "time": 25,
                            "imageName": "beans_rice_image.jpg"
                        },
                        {
                            "name": "Fruit Smoothie",
                            "description": "Blended smoothie with a mix of fruits, greens, and almond milk.",
                            "ingredients": ["Mixed fruits (e.g., banana, berries)", "Leafy greens (e.g., spinach, kale)", "Almond milk", "Ice"],
                            "instructions": "1. In a blender, combine mixed fruits, leafy greens, almond milk, and ice.\\n2. Blend until smooth and creamy.\\n3. Adjust the consistency by adding more almond milk if needed.\\n4. Pour into a glass and enjoy.",
                            "kcal": 250,
                            "time": 10,
                          "imageName": "blended_smoothie_image.jpg"
                        }

                    ]
                }
            ]
        }
        """

           do {
               let jsonData = jsonString.data(using: .utf8)!
               let decodedData = try JSONDecoder().decode(NutritionData.self, from: jsonData)

               completion(.success(decodedData))
           } catch {
               completion(.failure(error))
           }
       }
    
    
    func getVegetarian(completion: @escaping (Result<NutritionData, Error>) -> Void) {
        let jsonString = """
          {
            "nutrition": [
                {
                    "category": "Vegetarian",
                    "description":  "Without meat product" ,
                    "foods": [
                        {
                            "name": "Vegetable Stir-Fry",
                            "description": "Assorted vegetables sautéed in olive oil and soy sauce.",
                            "ingredients": ["Broccoli", "Bell peppers", "Carrots", "Zucchini", "Snap peas", "Olive oil", "Soy sauce", "Garlic", "Ginger"],
                            "instructions": "1. Heat olive oil in a pan. \\n2. Add garlic and ginger, sauté until fragrant. \\n3. Add vegetables and stir-fry until tender-crisp. \\n4. Pour soy sauce over the vegetables and toss. \\n5. Serve hot.",
                            "kcal": 250,
                            "time": 15,
                            "imageName": "Mixed_Vegetable_image.jpg"
                        },
                        {
                            "name": "Quinoa and Black Bean Salad",
                            "description": "Quinoa mixed with black beans, corn, tomatoes, and a lime vinaigrette.",
                            "ingredients": ["Quinoa", "Black beans", "Corn", "Tomatoes", "Lime", "Olive oil", "Cilantro", "Salt", "Pepper"],
                            "instructions": "1. Cook quinoa according to package instructions. \\n2. In a bowl, combine cooked quinoa, black beans, corn, and diced tomatoes. \\n3. In a small bowl, whisk together lime juice, olive oil, cilantro, salt, and pepper. \\n4. Pour the dressing over the quinoa mixture and toss. \\n5. Chill in the refrigerator before serving.",
                            "kcal": 300,
                            "time": 20,
                            "imageName": "Quinoa_salad_image.jpg"
                        },
                        {
                            "name": "Eggplant Parmesan",
                            "description": "Baked layers of eggplant with marinara sauce and melted cheese.",
                            "ingredients": ["Eggplant", "Marinara sauce", "Mozzarella cheese", "Parmesan cheese", "Breadcrumbs", "Italian seasoning"],
                            "instructions": "1. Preheat the oven to 375°F (190°C). \\n2. Slice eggplant into rounds, dip in breadcrumbs mixed with Italian seasoning. \\n3. Bake until golden brown. \\n4. In a baking dish, layer baked eggplant, marinara sauce, and cheeses. \\n5. Bake until cheese is melted and bubbly.",
                            "kcal": 350,
                            "time": 30,
                           "imageName": "EggplantParmesan_image.jpg"
                        },
                        {
                            "name": "Chickpea and Spinach Curry",
                            "description": "Chickpeas and spinach cooked in a flavorful curry sauce.",
                            "ingredients": ["Chickpeas", "Spinach", "Tomatoes", "Coconut milk", "Curry spices", "Onions", "Garlic", "Ginger"],
                            "instructions": "1. In a pot, sauté onions, garlic, and ginger until softened. \\n2. Add curry spices and cook until fragrant. \\n3. Stir in chickpeas, tomatoes, and coconut milk. \\n4. Simmer until chickpeas are tender. \\n5. Add spinach and cook until wilted.",
                            "kcal": 400,
                            "time": 25,
                           "imageName": "Chickpea_image.jpg"
                        },
                        {
                            "name": "Mushroom and Spinach Quesadilla",
                            "description": "Quesadilla filled with sautéed mushrooms, spinach, and melted cheese.",
                            "ingredients": ["Mushrooms", "Spinach", "Whole wheat tortillas", "Cheese", "Olive oil", "Garlic", "Salt", "Pepper"],
                            "instructions": "1. In a pan, sauté mushrooms and garlic in olive oil until tender. \\n2. Add spinach and cook until wilted. \\n3. Place a tortilla in a pan, add cheese, sautéed mushrooms, and spinach. \\n4. Top with another tortilla and cook until the cheese is melted. \\n5. Repeat for additional quesadillas.",
                            "kcal": 300,
                            "time": 20,
                            "imageName": "Mushroom_image.jpg"
          
                        }
                    ]
                }
            ]
          }
          """

           do {
               let jsonData = jsonString.data(using: .utf8)!
               let decodedData = try JSONDecoder().decode(NutritionData.self, from: jsonData)

               completion(.success(decodedData))
           } catch {
               completion(.failure(error))
           }
       }
    
    func getDessertsWithoutSugar(completion: @escaping (Result<NutritionData, Error>) -> Void) {
        let jsonString = """
             {
                 "nutrition": [
                     {
                         "category": "Desserts without sugar",
                         "description": "Low-calorie recipes for weight loss",
                         "foods": [
                             {
                                 "name": "Chia Seed Pudding",
                                 "description": "Creamy chia seed pudding made with almond milk and topped with fresh berries.",
                                 "ingredients": ["Chia seeds", "Almond milk", "Vanilla extract", "Fresh berries for topping"],
                                 "instructions": "1. Mix chia seeds, almond milk, and vanilla extract in a jar.\\n2. Refrigerate overnight.\\n3. Top with fresh berries before serving.",
                                 "kcal": 220,
                                 "time": 240,
                                 "imageName": "chiaseed_image.jpg"
                             },
                             {
                                 "name": "Coconut Almond Energy Bites",
                                 "description": "No-bake energy bites with coconut, almonds, and dates.",
                                 "ingredients": ["Dates", "Almonds", "Shredded coconut", "Cocoa powder", "Vanilla extract"],
                                 "instructions": "1. Blend dates, almonds, shredded coconut, cocoa powder, and vanilla extract in a food processor.\\n2. Roll into bite-sized balls.\\n3. Refrigerate until firm.",
                                 "kcal": 150,
                                 "time": 20,
                                 "imageName": "coconutalmond_image.jpg"
                             },
                             {
                                 "name": "Avocado Chocolate Mousse",
                                 "description": "Silky chocolate mousse made with ripe avocados and unsweetened cocoa powder.",
                                 "ingredients": ["Ripe avocados", "Cocoa powder", "Maple syrup (optional)", "Vanilla extract"],
                                 "instructions": "1. Blend avocados, cocoa powder, maple syrup (optional), and vanilla extract until smooth.\\n2. Chill before serving.",
                                 "kcal": 180,
                                 "time": 15,
                                 "imageName": "veganchoco_image.jpg"
                             },
                             {
                                 "name": "Berry Coconut Frozen Yogurt",
                                 "description": "Homemade frozen yogurt with mixed berries and coconut flakes.",
                                 "ingredients": ["Greek yogurt", "Mixed berries", "Coconut flakes", "Honey (optional)"],
                                 "instructions": "1. Blend Greek yogurt and mixed berries until smooth.\\n2. Stir in coconut flakes.\\n3. Freeze until firm.\\n4. Drizzle with honey if desired.",
                                 "kcal": 160,
                                 "time": 240,
                                 "imageName": "Berry_image.jpg"
                             }
                         ]
                     }
                 ]
             }

         """

        do {
            let jsonData = jsonString.data(using: .utf8)!
            let decodedData = try JSONDecoder().decode(NutritionData.self, from: jsonData)

            completion(.success(decodedData))
        } catch {
            completion(.failure(error))
        }
    }

    
    func getDessert(completion: @escaping (Result<NutritionData, Error>) -> Void) {
        let jsonString = """
        {
            "nutrition": [
                {
                    "category": "Desserts",
                    "description": "Sweet, traditional desserts",
                    "foods": [
                        {
                            "name": "Classic Chocolate Cake",
                            "description": "Moist chocolate cake layered with rich chocolate frosting.",
                            "ingredients": ["All-purpose flour", "Cocoa powder", "Baking powder", "Butter", "Sugar", "Eggs", "Milk", "Vanilla extract", "Chocolate ganache for frosting"],
                            "instructions": "1. Preheat the oven to 350°F (180°C).\\n2. In a bowl, whisk together flour, cocoa powder, and baking powder.\\n3. In another bowl, cream butter and sugar.\\n4. Add eggs one at a time, beating well after each addition.\\n5. Gradually add the dry ingredients, alternating with milk.\\n6. Stir in vanilla extract.\\n7. Pour the batter into greased cake pans.\\n8. Bake until a toothpick comes out clean.\\n9. Cool, then frost with chocolate ganache.",
                            "kcal": 400,
                            "time": 45,
                            "imageName": "classicho_image.jpg"
                        },
                        {
                            "name": "Apple Pie",
                            "description": "A classic apple pie with a flaky crust and cinnamon-spiced apple filling.",
                            "ingredients": ["Pie crust", "Apples", "Sugar", "Cinnamon", "Lemon juice", "Butter"],
                            "instructions": "1. Preheat the oven to 375°F (190°C).\\n2. Roll out pie crust and place it in a pie dish.\\n3. Peel, core, and slice apples.\\n4. Toss apples with sugar, cinnamon, and lemon juice.\\n5. Fill the pie crust with the apple mixture.\\n6. Dot with butter.\\n7. Cover with a second pie crust or create a lattice pattern.\\n8. Bake until the crust is golden brown.",
                            "kcal": 350,
                            "time": 40,
                           "imageName": "Applepie_image.jpg"
                        },
                        {
                            "name": "Vanilla Custard",
                            "description": "Smooth and creamy vanilla custard topped with a sprinkle of nutmeg.",
                            "ingredients": ["Milk", "Eggs", "Sugar", "Vanilla extract", "Nutmeg"],
                            "instructions": "1. Preheat the oven to 325°F (163°C).\\n2. In a saucepan, heat milk until hot but not boiling.\\n3. In a bowl, whisk together eggs, sugar, and vanilla extract.\\n4. Slowly pour the hot milk into the egg mixture, whisking continuously.\\n5. Strain the mixture and pour into custard cups.\\n6. Sprinkle with nutmeg.\\n7. Place the cups in a baking dish filled with hot water.\\n8. Bake until the custard is set.",
                            "kcal": 250,
                            "time": 30,
                             "imageName": "vanillacus_image.jpg"
                        },
                        {
                            "name": "Strawberry Shortcake",
                            "description": "Light and fluffy shortcakes layered with fresh strawberries and whipped cream.",
                            "ingredients": ["All-purpose flour", "Baking powder", "Sugar", "Butter", "Milk", "Strawberries", "Whipped cream"],
                            "instructions": "1. Preheat the oven to 425°F (218°C).\\n2. In a bowl, combine flour, baking powder, and sugar.\\n3. Cut in butter until the mixture resembles coarse crumbs.\\n4. Stir in milk until just combined.\\n5. Drop spoonfuls of dough onto a baking sheet.\\n6. Bake until golden brown.\\n7. Slice the shortcakes, fill with sliced strawberries, and top with whipped cream.",
                            "kcal": 300,
                            "time": 35,
                            "imageName": "strewberry_image.jpg"
                        },
                        {
                            "name": "Chocolate Chip Cookies",
                            "description": "Classic chocolate chip cookies with a chewy center and crispy edges.",
                            "ingredients": ["All-purpose flour", "Baking soda", "Butter", "Sugar", "Brown sugar", "Eggs", "Vanilla extract", "Chocolate chips"],
                            "instructions": "1. Preheat the oven to 375°F (190°C).\\n2. In a bowl, whisk together flour and baking soda.\\n3. In another bowl, cream butter, sugar, and brown sugar.\\n4. Add eggs one at a time, beating well after each addition.\\n5. Stir in vanilla extract.\\n6. Gradually add the dry ingredients, mixing until combined.\\n7. Fold in chocolate chips.\\n8. Drop spoonfuls of dough onto a baking sheet.\\n9. Bake until golden brown.",
                            "kcal": 200,
                            "time": 20,
                            "imageName": "Chocolate_Chip_image.jpg"
                        }
                    ]
                }
            ]
        }

        """

        do {
            let jsonData = jsonString.data(using: .utf8)!
            let decodedData = try JSONDecoder().decode(NutritionData.self, from: jsonData)

            completion(.success(decodedData))
        } catch {
            completion(.failure(error))
        }
    }
    func getNoMilk(completion: @escaping (Result<NutritionData, Error>) -> Void) {
        let jsonString = """
        {
            "nutrition": [
                {
                    "category": "Without milk",
                    "description": "Recipes without dairy products",
                    "foods": [
                        {
                            "name": "Creamy Coconut Curry",
                            "description": "A flavorful curry made with coconut milk instead of dairy.",
                            "ingredients": ["Vegetables of choice (e.g., cauliflower, carrots, bell peppers, peas)", "Coconut milk", "Curry spices", "Onions", "Garlic", "Ginger", "Cooking oil", "Basmati rice for serving"],
                            "instructions": "1. In a pot, sauté onions, garlic, and ginger in cooking oil until softened.\\n2. Add curry spices and cook until fragrant.\\n3. Add vegetables and stir to coat in the spices.\\n4. Pour in coconut milk and simmer until the vegetables are tender.\\n5. Serve over basmati rice.",
                            "kcal": 450,
                            "time": 30,
                            "imageName": "creamycoc_image.jpg"
                        },
                        {
                            "name": "Vegan Chocolate Avocado Mousse",
                            "description": "Rich and creamy chocolate mousse made with avocado instead of dairy.",
                            "ingredients": ["Ripe avocados", "Cocoa powder", "Maple syrup or agave nectar", "Vanilla extract", "Salt", "Almond milk (optional for consistency)", "Fresh berries for garnish"],
                            "instructions": "1. Blend ripe avocados, cocoa powder, maple syrup or agave nectar, vanilla extract, and a pinch of salt until smooth.\\n2. Add almond milk if needed to achieve desired consistency.\\n3. Chill the mousse in the refrigerator.\\n4. Serve topped with fresh berries.",
                            "kcal": 300,
                            "time": 20,
                            "imageName": "veganchocoavomo_image.jpg"
                        },
                        {
                            "name": "Dairy-Free Basil Pesto Pasta",
                            "description": "Pasta tossed in a flavorful basil pesto without any dairy ingredients.",
                            "ingredients": ["Fresh basil leaves", "Pine nuts", "Garlic", "Nutritional yeast", "Olive oil", "Lemon juice", "Salt", "Black pepper", "Pasta of choice"],
                            "instructions": "1. In a food processor, blend basil, pine nuts, garlic, and nutritional yeast until finely chopped.\\n2. With the processor running, slowly add olive oil and lemon juice until a smooth pesto forms.\\n3. Season with salt and black pepper to taste.\\n4. Toss the pesto with cooked pasta.",
                            "kcal": 350,
                            "time": 25,
                            "imageName": "Dairypestopasta_image.jpg"
                        },
                        {
                            "name": "Dairy-Free Banana Bread",
                            "description": "A moist and delicious banana bread without any dairy or milk.",
                            "ingredients": ["Ripe bananas", "Vegetable oil", "Maple syrup or agave nectar", "Flaxseed meal (mixed with water as an egg substitute)", "Vanilla extract", "All-purpose flour", "Baking soda", "Cinnamon", "Walnuts or chocolate chips (optional)"],
                            "instructions": "1. Preheat the oven to 350°F (180°C).\\n2. In a bowl, mash ripe bananas and add vegetable oil, maple syrup or agave nectar, flaxseed meal mixture, and vanilla extract.\\n3. In a separate bowl, whisk together flour, baking soda, and cinnamon.\\n4. Combine wet and dry ingredients, and fold in nuts or chocolate chips if using.\\n5. Pour the batter into a greased loaf pan and bake until a toothpick comes out clean.",
                            "kcal": 200,
                            "time": 40,
                            "imageName": "Dairy_Free_image.jpg"
                        },
                        {
                            "name": "Spicy Chickpea and Vegetable Stir-Fry",
                            "description": "A quick and flavorful stir-fry with chickpeas and veggies in a dairy-free sauce.",
                            "ingredients": ["Chickpeas (canned or cooked)", "Mixed vegetables (e.g., bell peppers, broccoli, snap peas)", "Soy sauce", "Sesame oil", "Garlic", "Ginger", "Chili flakes", "Cooked quinoa for serving"],
                            "instructions": "1. In a wok or skillet, stir-fry mixed vegetables in sesame oil until slightly tender.\\n2. Add chickpeas, soy sauce, minced garlic, ginger, and chili flakes.\\n3. Continue to stir-fry until everything is well coated and heated through.\\n4. Serve over cooked quinoa.",
                            "kcal": 400,
                            "time": 15,
                            "imageName": "Spicy_Chickpea_image.jpg"
                        }
                    ]
                }
            ]
        }

        """

        do {
            let jsonData = jsonString.data(using: .utf8)!
            let decodedData = try JSONDecoder().decode(NutritionData.self, from: jsonData)

            completion(.success(decodedData))
        } catch {
            completion(.failure(error))
        }
    }
    
    func getKeto(completion: @escaping (Result<NutritionData, Error>) -> Void) {
        let jsonString = """
        {
          "nutrition": [
            {
              "category": "Keto",
              "description": "For a keto diet, based on fats",
              "foods": [
                {
                  "name": "Avocado Bacon and Egg ",
                  "description": "Baked avocado halves filled with eggs and topped with crispy bacon.",
                  "ingredients": ["Avocados", "Eggs", "Bacon strips", "Salt", "Pepper", "Chives for garnish"],
                  "instructions": "1. Preheat the oven to 375°F (190°C).\\n2. Cut avocados in half, remove pits, and place in a baking dish. \\n3. Crack an egg into each avocado half.\\n4. Season with salt and pepper.\\n5. Bake until the eggs are set.\\n6. Top with crispy bacon and garnish with chives.",
                  "kcal": 300,
                  "time": 30,
                "imageName": "ketoavobacon_image.jpg"
                },
                {
                  "name": "Cauliflower Mac and Cheese",
                  "description": "Low-carb cauliflower florets coated in a cheesy keto-friendly sauce.",
                  "ingredients": ["Cauliflower florets", "Heavy cream", "Cream cheese", "Cheddar cheese", "Butter", "Garlic powder", "Mustard powder", "Salt", "Pepper"],
                  "instructions": "1. Steam cauliflower until tender-crisp.\\n2. In a saucepan, melt butter and add heavy cream, cream cheese, cheddar cheese, garlic powder, mustard powder, salt, and pepper.\\n3. Stir until the cheese is melted and the sauce is smooth.\\n4. Pour the cheese sauce over the cauliflower.",
                  "kcal": 250,
                  "time": 25,
                "imageName": "ketoCauMac_image.jpg"
                },
                {
                  "name": "Keto Chicken Alfredo Zucchini Noodles",
                  "description": "Zucchini noodles tossed in a creamy Alfredo sauce with grilled chicken.",
                  "ingredients": ["Zucchini noodles", "Grilled chicken breast strips", "Heavy cream", "Parmesan cheese", "Butter", "Garlic", "Salt", "Pepper", "Parsley for garnish"],
                  "instructions": "1. In a skillet, melt butter and sauté garlic.\\n2. Add heavy cream, Parmesan cheese, salt, and pepper.\\n3. Stir until the sauce thickens.\\n4. Toss zucchini noodles and grilled chicken in the Alfredo sauce.\\n5. Garnish with parsley before serving.",
                  "kcal": 400,
                  "time": 35,
                "imageName": "ketochickennod_image.jpg"
                },
                {
                  "name": "Beef and Broccoli Stir-Fry",
                  "description": "Tender beef strips and broccoli florets stir-fried in a keto-friendly sauce.",
                  "ingredients": ["Beef sirloin strips", "Broccoli florets", "Soy sauce", "Sesame oil", "Garlic", "Ginger", "Erythritol or stevia for sweetness", "Salt", "Pepper"],
                  "instructions": "1. In a wok or skillet, stir-fry beef strips until browned.\\n2. Add broccoli, garlic, and ginger.\\n3. In a bowl, mix soy sauce, sesame oil, erythritol or stevia, salt, and pepper.\\n4. Pour the sauce over the beef and broccoli.\\n5. Stir-fry until the broccoli is tender-crisp.",
                  "kcal": 350,
                  "time": 20,
                "imageName": "beefbroccoli_image.jpg"
                },
                {
                  "name": "Chocolate Avocado Pudding",
                  "description": "Creamy chocolate pudding made with ripe avocados and sweetened with keto-friendly sweeteners.",
                  "ingredients": ["Ripe avocados", "Cocoa powder", "Almond milk", "Erythritol or stevia for sweetness", "Vanilla extract"],
                  "instructions": "1. Blend ripe avocados, cocoa powder, almond milk, erythritol or stevia, and vanilla extract until smooth.\\n2. Adjust sweetness to taste.\\n3. Chill in the refrigerator before serving.",
                  "kcal": 200,
                  "time": 15,
                "imageName": "ketochoco_image.jpg"
                }
              ]
            }
          ]
        }

        """

        do {
            let jsonData = jsonString.data(using: .utf8)!
            let decodedData = try JSONDecoder().decode(NutritionData.self, from: jsonData)

            completion(.success(decodedData))
        } catch {
            completion(.failure(error))
        }
    }
    
    
   }
    
   





















