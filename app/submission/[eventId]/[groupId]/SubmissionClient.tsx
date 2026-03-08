'use client'
import { getGoupChallengeSubmission, saveGroupChallengeSubmission } from "@/app/actions/submissions"
import { useNotification } from "@/app/context/NotificationContext"
import { EventChallenge } from "@/app/types/event_challenges"
import { GroupChallengeRelation } from "@/app/types/group_challenge"
import { SubmissionInsert } from "@/app/types/submission"
import { SimpleEditor } from "@/components/tiptap-templates/simple/simple-editor"
import { Editor } from "@tiptap/core"
import { useState } from "react"
import { useForm } from "react-hook-form"

const SubmissionClient = ({ groupChallenges, eventChallenges, group_id }: { groupChallenges: Array<GroupChallengeRelation>, eventChallenges: Array<EventChallenge>, group_id: string }) => {
    const {
        register,
        handleSubmit,
        formState: { errors },
        reset,
    } = useForm<SubmissionInsert>()
    const [chosenGroupChallenges, setChosenGroupChallenges] = useState<number | null>(null)
    const [initialEditorContent, setInitialEditorContent] = useState<string | null>(null)
    const [editorValue, setEditorValue] = useState<Editor | null>(null)
    const { showNotification } = useNotification()

    const handleSaveSubmission = async (data: SubmissionInsert) => {
        console.log(data)
        try {
            data.group_id = group_id
            data.group_challenge_id = groupChallenges[chosenGroupChallenges!].id
            data.description = editorValue?.getHTML()
            if (data.group_id == null || data.group_id == "") {
                throw new Error('Fail to save because unknown error')
            }
            if (data.group_challenge_id == null || data.group_challenge_id == "") {
                throw new Error('Fail to save because unknown error')
            }
            await saveGroupChallengeSubmission({ submission: data })
            showNotification('Save submission successfully')
        } catch (error) {
            if (error instanceof Error) {
                showNotification(error.message)
            }
        }
    }
    console.log(initialEditorContent)
    const handleChooseChallengeSubmission = async (index: number) => {
        try {
            const data = await getGoupChallengeSubmission({ groupChallengeId: groupChallenges[index].id, groupId: groupChallenges[index].group_id! })
            setChosenGroupChallenges(index)
            if (data) {
                reset(data)
                setInitialEditorContent(data.description)
            } else {
                reset({
                    id: undefined,
                    github_link: "",
                    youtube_link: "",
                    short_description: "",
                    group_challenge_id: undefined,
                    group_id: undefined,
                    created_at: undefined
                })
                setInitialEditorContent(null)
            }

        } catch (error) {
            if (error instanceof Error) {
                showNotification(error.message)
            }
        }
    }
    return (
        <form className="flex flex-col pt-5 pb-10 gap-5 items-start" onSubmit={handleSubmit(handleSaveSubmission)}>
            <div className="flex flex-col gap-4 w-full mt-4">
                <div className="text-lg font-bold uppercase tracking-tight">Select Challenges</div>
                <div className="grid grid-cols-2 gap-4">
                    {eventChallenges.map((challenge, index) => (
                        <div key={challenge.id} className={`rounded-xl group relative cursor-pointer duration-300 ${chosenGroupChallenges == index ? 'shadow-xl/30 translate-y-2' : ''}`
                        } onClick={() => handleChooseChallengeSubmission(index)}>

                            <div className="relative w-full p-5 border rounded-xl peer-checked:border-black peer-checked:bg-gray-50 transition-all">
                                <div className="text-sm w-2/3 font-light">{challenge.company_name}</div>
                                <h4 className="font-bold w-2/3">{challenge.title}</h4>

                            </div>
                        </div>
                    ))}
                </div>
            </div>
            {chosenGroupChallenges != null &&
                <>
                    <div className="input-group w-full">
                        <label className="event_input_label">Github Link</label>
                        <input autoComplete="off" placeholder="Github source code link" id="Title" className="event_input outline-none w-full  h-[40px] placeholder:font-bold " type="text"

                            {...register('github_link', {
                                required: "Github link is required",
                            })} />
                        {errors.github_link && (
                            <p className="text-red-500 text-sm mt-1">
                                {errors.github_link.message}
                            </p>
                        )}
                    </div>
                    <div className="input-group w-full">
                        <label className="event_input_label">Youtube Link</label>
                        <input autoComplete="off" placeholder="Demo video link" id="Title" className="event_input outline-none w-full  h-[40px] placeholder:font-bold " type="text"

                            {...register('youtube_link', {
                                required: "Youtube link is required",
                            })} />
                        {errors.github_link && (
                            <p className="text-red-500 text-sm mt-1">
                                {errors.github_link.message}
                            </p>
                        )}
                    </div>

                    <div className="input-group w-full ">
                        <label className="event_input_label">Short Description</label>
                        <textarea
                            autoComplete="off"
                            placeholder="Short Description"
                            className="event_input outline-none w-full placeholder:font-bold h-[80px]"
                            {...register('short_description', {
                                required: "Short description is required",
                            })}
                        />
                        {errors.short_description && (
                            <p className="text-red-500 text-sm mt-1">
                                {errors.short_description.message}
                            </p>
                        )}
                    </div>
                    <div className="shadow-xl/30 inset-shadow-sm rounded-xl ">
                        <SimpleEditor initialContent={initialEditorContent} onEditorReady={setEditorValue} />
                    </div>
                    <button
                        type="submit"
                        className="cursor-pointer px-6 py-2 rounded-md bg-black hover:bg-black/80 transition-colors duration-300 text-white"
                    >
                        Save your submission
                    </button>
                </>
            }
        </form>
    )
}

export default SubmissionClient