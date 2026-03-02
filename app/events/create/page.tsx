'use client'
import { EventAttributes } from "@/app/types/event"
import { SimpleEditor } from "@/components/tiptap-templates/simple/simple-editor"
import { Editor } from "@tiptap/core"
import { useState } from "react"
import { useForm } from "react-hook-form"

const Home = () => {
    const {
        register,
        handleSubmit,
        formState: { errors }
    } = useForm<EventAttributes>()

    const [editorValue, setEditorValue] = useState<Editor | null>(null)

    const handleCreateNewEvent = (event: EventAttributes) => {
        console.log(event)
        console.log(editorValue?.getHTML())
    }

    return (
        <div className="w-full min-h-screen screen-bg font-roboto-mono">
            <div className="max-w-4xl mx-auto px-6">
                <form className="flex flex-col pt-5 pb-10 gap-5 items-start" onSubmit={handleSubmit(handleCreateNewEvent)}>
                    <div className="w-full flex gap-5">
                        <div className="input-group w-full">
                            <label className="label">Title</label>
                            <input autoComplete="off" placeholder="Project title" id="Title" className="event_input outline-none w-full  h-[40px] placeholder:font-bold " type="text"

                                {...register('title', {
                                    required: "Title is required",
                                })} />
                            {errors.title && (
                                <p className="text-red-500 text-sm mt-1">
                                    {errors.title.message}
                                </p>
                            )}
                        </div>
                    </div>
                    <div className="w-full flex gap-5">
                        <div className="input-group w-1/2">
                            <label className="label">Start Date</label>
                            <input autoComplete="off" placeholder="Start Date" id="StartDate" className="event_input outline-none w-full  h-[40px] placeholder:font-bold " type="date"
                                {...register('startDate', {
                                    required: "Start date is required",
                                })}
                            />
                            {errors.startDate && (
                                <p className="text-red-500 text-sm mt-1">
                                    {errors.startDate.message}
                                </p>
                            )}
                        </div>
                        <div className="input-group w-1/2">
                            <label className="label">End Date</label>
                            <input autoComplete="off" id="EndDate" placeholder="End Date" className="event_input outline-none w-full  h-[40px] placeholder:font-bold" type="date"
                                {...register('endDate', {
                                    required: "End date is required",
                                })}
                            />
                            {errors.endDate && (
                                <p className="text-red-500 text-sm mt-1">
                                    {errors.endDate.message}
                                </p>
                            )}
                        </div>
                    </div>
                    <div className="w-full flex gap-5">
                        <div className="input-group w-1/2">
                            <label className="label">Location</label>
                            <input autoComplete="off" placeholder="Location" id="Location" className="event_input outline-none w-full  h-[40px] placeholder:font-bold " type="text"
                                {...register('location', {
                                    required: "Location is required",
                                })}
                            />
                            {errors.location && (
                                <p className="text-red-500 text-sm mt-1">
                                    {errors.location.message}
                                </p>
                            )}
                        </div>
                        <div className="input-group w-1/2">
                            <label className="label">Organized Date</label>
                            <input autoComplete="off" id="OrganizedDate" placeholder="Organized Date" className="event_input outline-none w-full  h-[40px] placeholder:font-bold" type="datetime-local"
                                {...register('organizedDate', {
                                    required: "Organized Date is required",
                                })}
                            />
                            {errors.organizedDate && (
                                <p className="text-red-500 text-sm mt-1">
                                    {errors.organizedDate.message}
                                </p>
                            )}
                        </div>
                    </div>
                    <div className="input-group w-full">
                        <label className="label">Max member per teams</label>
                        <input autoComplete="off" min="1"
                            step="1"
                            id="MaxMember"
                            placeholder="Max member per teams"
                            className="event_input outline-none w-[80px]  h-[40px] placeholder:font-bold"
                            type="number"
                            {...register('maxGroupMembers', {
                                required: "Max group members is required",
                            })}
                        />
                        {errors.maxGroupMembers && (
                            <p className="text-red-500 text-sm mt-1">
                                {errors.maxGroupMembers.message}
                            </p>
                        )}
                    </div>
                    <div className="input-group w-full ">
                        <label className="label">Short Description</label>
                        <textarea
                            autoComplete="off"
                            placeholder="Short Description"
                            className="event_input outline-none w-full placeholder:font-bold h-[80px]"
                            {...register('shortDescription', {
                                required: "Short description members is required",
                            })}
                        />
                        {errors.shortDescription && (
                            <p className="text-red-500 text-sm mt-1">
                                {errors.shortDescription.message}
                            </p>
                        )}
                    </div>
                    <div className="shadow-xl/30 inset-shadow-sm rounded-xl ">
                        <SimpleEditor onEditorReady={setEditorValue} />
                    </div>
                    <button
                        type="submit"
                        className="cursor-pointer px-6 py-2 rounded-md bg-white/20 hover:bg-white/30 transition-colors duration-300 text-white"
                    >
                        Create New
                    </button>
                </form>
            </div>
        </div>
    )
}


export default Home